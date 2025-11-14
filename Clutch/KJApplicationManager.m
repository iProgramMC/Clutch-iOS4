//
//  ApplicationsManager.m
//  Clutch
//
//  Created by Anton Titkov on 09.02.15.
//
//

#define applistCachePath @"applist-cache.plist"
#define dumpedAppPath @"/etc/dumped.clutch"

#import "KJApplicationManager.h"
#import <dlfcn.h>

typedef NSDictionary *(*MobileInstallationLookup)(NSDictionary *options);

@interface KJApplicationManager ()
@property (nonatomic, retain) NSMutableArray *cachedApps;
@end

@implementation KJApplicationManager

- (instancetype)init {
    if ((self = [super init])) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:applistCachePath]) {
            _cachedApps = [[NSMutableArray alloc] initWithContentsOfFile:applistCachePath];
        } else {
            _cachedApps = [NSMutableArray new];
        }
    }

    return self;
}

- (NSDictionary *)listApplicationsForiOS7AndLower {
    MobileInstallationLookup mobileInstallationLookup;
    void *MIHandle;

    NSMutableDictionary *returnValue = [NSMutableDictionary new];
    MIHandle = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_NOW);
    mobileInstallationLookup = NULL;

    if (MIHandle) {
        mobileInstallationLookup = (MobileInstallationLookup)dlsym(MIHandle, "MobileInstallationLookup");
        if (mobileInstallationLookup) {

            NSDictionary *installedApps;
            NSDictionary *options = @{
                @"ApplicationType" : @"User",
                @"ReturnAttributes" : @[
                    @"CFBundleShortVersionString",
                    @"CFBundleVersion",
                    @"Path",
                    @"CFBundleDisplayName",
                    @"CFBundleExecutable",
                    @"MinimumOSVersion"
                ]
            };

            installedApps = mobileInstallationLookup(options);

            for (NSString *bundleID in installedApps.allKeys) {
                NSDictionary *appI = [installedApps objectForKey:bundleID];
                NSURL *bundleURL = [NSURL fileURLWithPath:[appI objectForKey:@"Path"]];
                NSString *scinfo = [bundleURL.path stringByAppendingPathComponent:@"SC_Info"];

                BOOL isDirectory;
                BOOL purchased = [[NSFileManager defaultManager] fileExistsAtPath:scinfo isDirectory:&isDirectory];

                if (purchased && isDirectory) {
                    NSString *name = [appI objectForKey:@"CFBundleDisplayName"];
                    if (name == nil) {
                        name = [appI objectForKey:@"CFBundleExecutable"];
                    }

                    NSDictionary *bundleInfo = @{
                        @"BundleContainer" : bundleURL.URLByDeletingLastPathComponent,
                        @"BundleURL" : bundleURL,
                        @"DisplayName" : name,
                        @"BundleIdentifier" : bundleID
                    };
                    Application *app = [[Application alloc] initWithBundleInfo:bundleInfo];
                    [returnValue setObject:app forKey:bundleID];

                    [self cacheBundle:bundleInfo];
                }
            }
        }
    }

    [self writeToCache];

    return returnValue;
}

- (void)writeToCache {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_async(queue, ^{
        [self.cachedApps writeToFile:applistCachePath atomically:YES];
    });
}

- (NSDictionary *)_allApplications {
    NSDictionary *returnValue;
    returnValue = [self listApplicationsForiOS7AndLower];
    return returnValue.copy;
}

- (NSDictionary *)installedApps {
    return [self _allApplications];
}

- (NSDictionary *)cachedApplications {
    if (_cachedApps.count < 1) {
        return [self _allApplications];
    }

    NSMutableDictionary *returnValue = [NSMutableDictionary new];
    for (NSDictionary *bundleInfo in _cachedApps) {
        Application *app = [[Application alloc] initWithBundleInfo:bundleInfo];
        [returnValue setObject:app forKey:[bundleInfo objectForKey:@"BundleIdentifier"]];
    }

    return returnValue;
}

- (void)cacheBundle:(NSDictionary *)bundle {
    [_cachedApps addObject:bundle];
}

- (NSArray *)dumpedApps {
    NSString *dumpedPath = @"";
    NSArray *array = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dumpedPath
                                                                                                        error:nil]];

    NSMutableArray *paths = [NSMutableArray new];

    for (NSUInteger i = 0; i < array.count; i++) {
        if (![[[array objectAtIndex:i] pathExtension] caseInsensitiveCompare:@"ipa"]) {
            [paths addObject:[array objectAtIndex:i]];
        }
    }

    return paths;
}

@end

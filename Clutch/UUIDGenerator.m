//
//  UUIDGenerator.m
//  Clutch iOS4 Port
//
//  Created by iProgramInCpp on 14/11/2025.
//
//

#import "UUIDGenerator.h"

@implementation UUIDGenerator

+ (NSString *)createUUID {
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
	NSString *uuidString = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
	CFRelease(uuidRef);
	CFRelease(uuidStringRef);
	return uuidString;
}

@end

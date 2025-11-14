//
//  ARM64Dumper.m
//  Clutch
//
//  Created by Anton Titkov on 22.03.15.
//
//

#import "ARM64Dumper.h"
#import "ClutchPrint.h"
#import "Device.h"
#import <dlfcn.h>
#import <mach-o/fat.h>
#import <mach/mach_init.h>
#import <mach/mach_traps.h>

@implementation ARM64Dumper

- (cpu_type_t)supportedCPUType {
    return CPU_TYPE_ARM64;
}

- (BOOL)dumpBinary {
	KJPrint(@"ARM64 dumping is NOT supported in this version!");
    return NO;
}

@end

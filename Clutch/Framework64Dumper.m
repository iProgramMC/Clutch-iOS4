//
//  Framework64Dumper.m
//  Clutch
//
//  Created by Anton Titkov on 02.04.15.
//
//

#import "Framework64Dumper.h"
#import "ClutchPrint.h"
#import "Device.h"
#import <spawn.h>

@implementation Framework64Dumper

- (cpu_type_t)supportedCPUType {
    return CPU_TYPE_ARM64;
}

- (BOOL)dumpBinary {
	KJPrint(@"ARM64 dumping of frameworks is NOT supported in this version!");
    return NO;
}

@end

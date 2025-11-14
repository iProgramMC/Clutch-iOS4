//
//  ARCShim.m
//  Clutch iOS4 Port
//
//  Created by iProgramInCpp on 14/11/2025.
//
//  This module provides a replacement for all of the ARC APIs
//  not provided by the iPhoneOS4.0.sdk.
//
#import <Foundation/Foundation.h>
#import <objc/objc.h>

id objc_retain(id obj) {
    return [obj retain];
}

void objc_release(id obj) {
    [obj release];
}

id objc_autorelease(id obj) {
    return [obj autorelease];
}

void objc_storeStrong(id *ptr, id obj) {
    id old = *ptr;
    [obj retain];
    *ptr = obj;
    [old release];
}

id objc_autoreleaseReturnValue(id obj) {
    return [obj autorelease];
}

id objc_retainAutoreleaseReturnValue(id obj) {
    [obj retain];
    return [obj autorelease];
}

id objc_retainAutoreleasedReturnValue(id obj) {
    return [obj retain];
}

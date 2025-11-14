#pragma once


#ifndef NS_OPTIONS
#define NS_OPTIONS(_type, _name) enum _name : _type _name; enum _name : _type
#endif
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#ifndef NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_BEGIN
#endif
#ifndef NS_ASSUME_NONNULL_END
#define NS_ASSUME_NONNULL_END
#endif
#ifndef FOUNDATION_EXTERN
#define FOUNDATION_EXTERN extern
#endif
#ifndef NS_DESIGNATED_INITIALIZER
#define NS_DESIGNATED_INITIALIZER
#endif

#ifdef OLD_IPHONE

#define nullable
#define instancetype id
#define NS_NONATOMIC_IOSONLY nonatomic
typedef dispatch_queue_t OS_dispatch_queue;

#endif

enum {
	CPU_SUBTYPE_ARM_V7 = 9,
	CPU_SUBTYPE_ARM_V7S = 11,
	CPU_SUBTYPE_ARM_V7K = 12,
	CPU_SUBTYPE_ARM_V8 = 13,
	CPU_SUBTYPE_ARM64_ALL = 0,
	CPU_SUBTYPE_ARM64_V8 = 1,
	CPU_SUBTYPE_X86_64_H = 8,
};

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ArcoreFlutterPlugin.h"

FOUNDATION_EXPORT double arcore_flutter_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char arcore_flutter_pluginVersionString[];


#import "SimplePedometerPlugin.h"
#if __has_include(<simple_pedometer/simple_pedometer-Swift.h>)
#import <simple_pedometer/simple_pedometer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "simple_pedometer-Swift.h"
#endif

@implementation SimplePedometerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimplePedometerPlugin registerWithRegistrar:registrar];
}
@end

import Flutter
import UIKit
import CoreMotion

public class SwiftSimplePedometerPlugin: NSObject, FlutterPlugin {
    
    let pedometer = CMPedometer();
    var channelResult: FlutterResult?;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "simple_pedometer", binaryMessenger: registrar.messenger())
        let instance = SwiftSimplePedometerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.channelResult = result;
        if (call.method.elementsEqual("getSteps")){
            getSteps(call: call)
        }  }
    
    func getSteps(call: FlutterMethodCall) {
        guard let arguments = call.arguments as? NSDictionary,
              let startTime = (arguments["startTime"] as? NSNumber),
              let endTime = (arguments["endTime"] as? NSNumber)
        else {
            self.channelResult!(0);
            return;
        }
        let dateFrom = Date(timeIntervalSince1970: startTime.doubleValue / 1000)
        let dateTo = Date(timeIntervalSince1970: endTime.doubleValue / 1000)
        pedometer.queryPedometerData(from: dateFrom, to: dateTo, withHandler: {(data, error) in
            if (error == nil){
                let steps = data!.numberOfSteps;
                self.channelResult!(steps.intValue)
                return;
            } else {
                self.channelResult!(0)
            }
        })
    }
}

# flutter_step_counter
Simple pedometer plugin for flutter iOS app.

### 🚨 Warning
This plugin is still under development and does **NOT** support android.
If you want this feature on android, please consider another plugin for that.

## Set up

- Add `NSMotionUsageDescription` to `iOS/Runner/Info.plist`
```
<dict>
    <key>NSMotionUsageDescription</key>
    <string>Motion usage description</string>
</dict>
</plist>
```

## Usage

- Use [permission_handler](https://pub.dev/packages/permission_handler) to handle MotionAndUsage permission.
- Use `SimplePedometer.getSteps`. It returns the pedometer data between the two specified DateTime.
```dart


final sensorsPermission = await Permission.sensors.request();
if (sensorsPermission.isDenied) {
  return;
}

/// get steps from 2022 to now.
final steps = stepsIn24Hours = await SimplePedometer.getSteps(
  from: DateTime(2022),
  to: DateTime.now(),
);

```
- ⚠️Caution: Only the past seven days worth of data is stored and available for you to retrieve. Specifying a start date that is more than seven days in the past returns only the available data.

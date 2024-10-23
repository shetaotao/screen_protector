# screen_protector

Safe Data Leakage via Application Background Screenshot and Prevent Screenshot for Ohos.

## Feature

### Import

```dart
import 'package:screen_protector_ohos/screen_protector.dart';
```


#### Protect Data Leakage Background Screenshot and Prevent Screenshot

- ON

```dart
await ScreenProtector.protectDataLeakageOn()
```

or

```dart
await ScreenProtector.preventScreenshotOn()
```

- OFF

```dart
await ScreenProtector.protectDataLeakageOff()
```

or

```dart
await ScreenProtector.preventScreenshotOff()
```

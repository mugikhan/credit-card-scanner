import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_scanner/views/credit_cards/capture_card_view.dart';
import 'package:flutter_card_scanner/widgets/circle_num_button.dart';
import 'package:flutter_card_scanner/widgets/take_photo_button.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key,
      required this.customPaint,
      required this.onImage,
      this.onCameraFeedReady,
      this.onDetectorViewModeChanged,
      this.onCameraLensDirectionChanged,
      this.initialCameraLensDirection = CameraLensDirection.back})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;

  bool showFocusCircle = false;
  double x = 0;
  double y = 0;

  InputImageRotation imageRotation = InputImageRotation.rotation0deg;

  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _liveFeedBody(context));
  }

  Widget _liveFeedBody(BuildContext context) {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Container(
      color: Colors.black,
      child: GestureDetector(
        onTapUp: (details) {
          _onTap(details);
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: _changingCameraLens
                  ? const Center(
                      child: Text('Changing camera lens'),
                    )
                  : CameraPreview(
                      _controller!,
                      child: widget.customPaint,
                    ),
            ),
            OrientationBuilder(
              builder: (context, orientation) {
                switch (orientation) {
                  case Orientation.portrait:
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _controlBar(
                                turns: 0,
                              ),
                              _pageText()
                            ],
                          ),
                        )
                      ],
                    );
                  case Orientation.landscape:
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: -1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _controlBar(
                                turns: 1,
                              ),
                              _pageText()
                            ],
                          ),
                        )
                      ],
                    );
                }
              },
            ),
            if (showFocusCircle)
              Positioned(
                  top: y - 20,
                  left: x - 20,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5)),
                  ))
            // _backButton(),
            // _switchLiveCameraToggle(),
            // _takePictureButton(context),
            // _zoomControl(),
            // _exposureControl(),
          ],
        ),
      ),
    );
  }

  Widget _controlBar({required int turns}) {
    return Column(
      children: [
        _zoomControlBar(turns: turns),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RotatedBox(
              quarterTurns: turns,
              child: IconButton(
                color: Colors.white,
                icon: _flashMode == FlashMode.always
                    ? const Icon(Icons.flash_on)
                    : const Icon(Icons.flash_off),
                onPressed: () {
                  setState(() {
                    if (_flashMode == FlashMode.off) {
                      _flashMode = FlashMode.always;
                    } else {
                      _flashMode = FlashMode.off;
                    }
                  });
                  _controller?.setFlashMode(_flashMode);
                },
              ),
            ),
            CustomPhotoButton(
              innerColor: Colors.white,
              innerShape: BoxShape.circle,
              onTap: () async {
                final image = await _controller?.takePicture();

                if (!mounted) return;

                if (context.mounted && image != null) {
                  await Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => CaptureCardView(
                        imagePath: image.path,
                        imageRotation: imageRotation,
                      ),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
            RotatedBox(
              quarterTurns: turns,
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.switch_camera),
                onPressed: _switchLiveCamera, //onNewCameraSelected(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _zoomControlBar({required int turns}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: turns,
            child: CircleNumButton(
              onTap: () async {
                setState(() {
                  _currentZoomLevel = 1.0;
                });
                await _controller?.setZoomLevel(1.0);
              },
              text: "1x",
              isSelected: _currentZoomLevel == 1.0,
            ),
          ),
          RotatedBox(
            quarterTurns: turns,
            child: CircleNumButton(
              onTap: () async {
                setState(() {
                  _currentZoomLevel = 2.0;
                });
                await _controller?.setZoomLevel(2.0);
              },
              text: "2x",
              isSelected: _currentZoomLevel == 2.0,
            ),
          ),
          RotatedBox(
            quarterTurns: turns,
            child: CircleNumButton(
              onTap: () async {
                setState(() {
                  _currentZoomLevel = 3.0;
                });
                await _controller?.setZoomLevel(3.0);
              },
              text: "3x",
              isSelected: _currentZoomLevel == 3.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 500),
            style: TextStyle(color: Colors.white),
            child: Text("PHOTO"),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(TapUpDetails details) async {
    if (_controller?.value.isInitialized != null &&
        _controller!.value.isInitialized) {
      setState(() {
        showFocusCircle = true;
      });
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _controller!.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);
      print("point : $point");

      // Manually focus
      await _controller?.setFocusPoint(point);

      // Manually set light exposure
      _controller?.setExposurePoint(point);

      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }

  Widget _switchLiveCameraToggle() => Positioned(
        bottom: 8,
        right: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: _switchLiveCamera,
            backgroundColor: Colors.black54,
            child: Icon(
              Platform.isIOS
                  ? Icons.flip_camera_ios_outlined
                  : Icons.flip_camera_android_outlined,
              size: 25,
            ),
          ),
        ),
      );

  Widget _zoomControl() => Positioned(
        bottom: 16,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentZoomLevel,
                    min: _minAvailableZoom,
                    max: _maxAvailableZoom,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentZoomLevel = value;
                      });
                      await _controller?.setZoomLevel(value);
                    },
                  ),
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _exposureControl() => Positioned(
        top: 40,
        right: 8,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 250,
          ),
          child: Column(children: [
            Container(
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${_currentExposureOffset.toStringAsFixed(1)}x',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  height: 30,
                  child: Slider(
                    value: _currentExposureOffset,
                    min: _minAvailableExposureOffset,
                    max: _maxAvailableExposureOffset,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentExposureOffset = value;
                      });
                      await _controller?.setExposureOffset(value);
                    },
                  ),
                ),
              ),
            )
          ]),
        ),
      );

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    if (_cameraIndex == 0) {
      _cameraIndex = 1;
    } else if (_cameraIndex == 1) {
      _cameraIndex = 0;
    }

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;
    setState(() {
      imageRotation = rotation!;
    });

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}

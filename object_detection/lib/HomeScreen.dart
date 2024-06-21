import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_pytorch/flutter_pytorch.dart';
//import 'package:flutter_pytorch/pigeon.dart';
import 'package:image/image.dart' as img;
import 'package:pytorch_lite/pytorch_lite.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:camera_avfoundation/camera_avfoundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _imageFile;
  ModelObjectDetection? _objectModel;
  String? _imagePrediction;
  List? _prediction;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];
  img.Image? decodedImage;
  Map<String, List<double>> detectionSummary = {};
  @override
  void initState() {
    super.initState();
    print("home screen initiated");
    loadModel();
  }

  Future<void> loadModel() async {
    //String pathObjectDetectionModel = "assets/models/best.torchscript";
    try {
      ModelObjectDetection objectModel =
          await PytorchLite.loadObjectDetectionModel(
              "assets/models/best.torchscript", 2, 416, 416,
              labelPath: "assets/labels/labels.txt",
              objectDetectionModelType: ObjectDetectionModelType.yolov5);
      //ModelObjectDetection model =
      //await FlutterPytorch.loadObjectDetectionModel("assets/models/best.torchscript",
      //2, 416, 416, labelPath: "assets/labels/labels.txt",
      //);
      setState(() {
        _objectModel = objectModel;
      });
    } catch (e) {
      if (e is PlatformException) {
        print("Only supported for Android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File image = File(result.files.single.path!);
      runObjectDetection(image);
    }
  }

  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File image = File(photo.path);
      runObjectDetection(image);
    }
  }

  Future<void> runObjectDetection(File image) async {
    if (_objectModel == null) {
      print("Model not loaded yet.");
      return;
    }
    /* print("HERE?");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print("image picked?");
    if (result != null) {
      print("image is null");
      File image = File(result.files.single.path!); */

    // Read the image bytes
    Uint8List imageBytes = await image.readAsBytes();

    // Decode the image
    decodedImage = img.decodeImage(imageBytes);

    int originalWidth = decodedImage!.width;
    int originalHeight = decodedImage!.height;
    int newWidth = 416;
    int newHeight = ((originalHeight / originalWidth) * newWidth).round();

    // Resize the image while maintaining aspect ratio
    img.Image resizedImage = img.copyResize(
      decodedImage!,
      width: newWidth,
      height: newHeight,
      interpolation: img.Interpolation.cubic,
    );

    // Convert resized image back to bytes
    Uint8List resizedImageBytes =
        Uint8List.fromList(img.encodeJpg(resizedImage));

    List<ResultObjectDetection?> detections =
        await _objectModel!.getImagePrediction(
      resizedImageBytes,
      minimumScore: 0.5,
      iOUThreshold: 0.5,
    );

    /* List<ResultObjectDetection?> detections =
          await _objectModel!.getImagePrediction(
        await File(image.path).readAsBytes(),
        minimumScore: 0.1,
        iOUThreshold: 0.3,
      ); */
    setState(() {
      _image = File(image.path);
      objDetect = detections;
      generateDetectionSummary();
    });

    objDetect.forEach((element) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });
  }

  void generateDetectionSummary() {
    Map<String, List<double>> summary = {};
    for (var detection in objDetect) {
      print("yes");
      if (detection != null) {
        print("loop");
        String className = detection.className!;
        double score = detection.score!;
        if (summary.containsKey(className)) {
          summary[className]!.add(score);
        } else {
          summary[className] = [score];
        }
      }
    }
    setState(() {
      detectionSummary = summary;
    });
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aircraft Detector and Classifier")),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image with Detections....
            Expanded(
              child: Container(
                height: 150,
                width: 1000,
                child: objDetect.isNotEmpty
                    ? _image == null
                        ? Text('No image selected.')
                        : _objectModel!.renderBoxesOnImage(_image!, objDetect)
                    : _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
              ),
            ),
            Center(
              child: Visibility(
                visible: _imagePrediction != null,
                child: Text("$_imagePrediction"),
              ),
            ),
            // Buttons for selecting image source
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    takePhoto();
                  },
                  child: const Icon(Icons.camera_alt),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  child: const Icon(Icons.photo_library),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aircraft Detector and Classifier")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Instructions
            Text(
              'Welcome to the Aircraft Detector and Classifier!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Please choose an option below to get started:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Display image with detections
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: objDetect.isNotEmpty
                    ? _image == null
                        ? Center(child: Text('No image selected.'))
                        : AspectRatio(
                            aspectRatio: decodedImage != null
                                ? decodedImage!.width / decodedImage!.height
                                : 1.0,
                            child: _objectModel!
                                .renderBoxesOnImage(_image!, objDetect),
                          )
                    : _image == null
                        ? Center(child: Text('No image selected.'))
                        : AspectRatio(
                            aspectRatio: decodedImage != null
                                ? decodedImage!.width / decodedImage!.height
                                : 1.0,
                            child: Image.file(_image!),
                          ),
              ),
            ),
            SizedBox(height: 20),
            // Buttons for selecting image source
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    takePhoto();
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take Photo'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Color.fromARGB(255, 232, 198, 255),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Upload from Gallery'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Color.fromARGB(255, 183, 226, 255),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display message when no image is selected
            if (_image == null)
              Text(
                'No image selected. Please select an image to start object detection.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),

            SizedBox(height: 20),
            buildDetectionSummary(),
          ],
        ),
      ),
    );
  }

  Widget buildDetectionSummary() {
    if (detectionSummary.isEmpty) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detection Summary:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...detectionSummary.entries.map((entry) {
            String aircraftType = entry.key[0].toUpperCase() +
                entry.key.substring(1, entry.key.length);
            List<double> scores = entry.value;
            String scoreText =
                scores.map((e) => (e * 100).toStringAsFixed(0)).join('%, ');

            String descText = (scores.length > 1)
                ? 'with confidence scores of $scoreText%'
                : (scores.isNotEmpty)
                    ? 'with a confidence score of $scoreText%'
                    : '';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '$aircraftType: ${scores.length} detected $descText',
                style: TextStyle(fontSize: 16),
              ),
            );
          }),
        ],
      ),
    );
  }
}

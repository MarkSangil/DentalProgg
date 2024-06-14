import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
  runApp(const classSignature());
}

// ignore: camel_case_types
class classSignature extends StatelessWidget {
  const classSignature({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _MyHomePageState extends State<MyHomePage> {
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint(
                        '${sign?.points.length} points in the signature');
                  },
                  strokeWidth: strokeWidth,
                ),
              ),
            ),
          ),
          _img.buffer.lengthInBytes == 0
              ? Container()
              : LimitedBox(
                  maxHeight: 200.0,
                  child: Image.memory(_img.buffer.asUint8List())),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () async {
                      final sign = _sign.currentState;
                      final image = await sign!.getData();
                      final data = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      final imageData = data!.buffer.asUint8List();

                      // Upload the image data to Firebase Storage
                      final storageRef = FirebaseStorage.instance
                          .ref()
                          .child('signatures/${DateTime.now()}.png');
                      final uploadTask = storageRef.putData(imageData);

                      // Wait for the upload to complete
                      await uploadTask.whenComplete(() =>
                          print('Signature uploaded to Firebase Storage'));

                      // Clear the signature pad
                      sign.clear();
                      setState(() {
                        _img = ByteData(0);
                      });
                    },
                    child: const Text("Save"),
                  ),
                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign?.clear();
                        setState(() {
                          _img = ByteData(0);
                        });
                        debugPrint("cleared");
                      },
                      child: const Text("Clear")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          color =
                              color == Colors.green ? Colors.red : Colors.green;
                        });
                        debugPrint("change color");
                      },
                      child: const Text("Change color")),
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          int min = 1;
                          int max = 10;
                          int selection = min + (Random().nextInt(max - min));
                          strokeWidth = selection.roundToDouble();
                          debugPrint("change stroke width to $selection");
                        });
                      },
                      child: const Text("Change stroke width")),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

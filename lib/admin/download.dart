import 'package:dentalprogapplication/admin/download_view.dart';
import 'package:flutter/material.dart';

class DownloadPage extends StatelessWidget {
  final String uid;
  const DownloadPage({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: DownloadViewPage(uid: uid),
    );
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'category_detail.dart';

class ChinesePage extends StatefulWidget {
  const ChinesePage({super.key});

  @override
  State<ChinesePage> createState() => _ChinesePageState();
}

class _ChinesePageState extends State<ChinesePage> {
  List<String> imageUrls = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailPage(category: '4', title: 'Chinese');
  }
}

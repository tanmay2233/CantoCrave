import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/category_detail.dart';

class MaggieOmelettePage extends StatefulWidget {
  const MaggieOmelettePage({super.key});

  @override
  State<MaggieOmelettePage> createState() => _MaggieOmelettePageState();
}

class _MaggieOmelettePageState extends State<MaggieOmelettePage> {
  List<String> imageUrls = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailPage(category: '3', title: 'Maggie & Omelettes');
  }
}

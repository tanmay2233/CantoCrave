import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/category_detail.dart';

class RollsCurriesPage extends StatefulWidget {
  const RollsCurriesPage({super.key});

  @override
  State<RollsCurriesPage> createState() => _RollsCurriesPageState();
}

class _RollsCurriesPageState extends State<RollsCurriesPage> {
  List<String> imageUrls = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailPage(category: '5', title: 'Rolls & Curries');
  }
}

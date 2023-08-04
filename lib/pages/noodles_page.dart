import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/category_detail.dart';

class NoodlesPage extends StatefulWidget {
  const NoodlesPage({super.key});

  @override
  State<NoodlesPage> createState() => _NoodlesPageState();
}

class _NoodlesPageState extends State<NoodlesPage> {
  List<String> imageUrls = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailPage(category: '1', title: 'Noodles & Pastas');
  }
}

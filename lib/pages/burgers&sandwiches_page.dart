import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'category_detail.dart';

class BurgerSandwichPage extends StatefulWidget {
  const BurgerSandwichPage({super.key});

  @override
  State<BurgerSandwichPage> createState() => _BurgerSandwichPageState();
}

class _BurgerSandwichPageState extends State<BurgerSandwichPage> {
  List<String> imageUrls = [];
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryDetailPage(category: '2', title: 'Burgers & Sandwiches');
  }
}
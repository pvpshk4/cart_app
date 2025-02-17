import 'package:flutter/material.dart';

class ProductItem {
  final String name, imageUrl;
  final double width, height;

  ProductItem(
      {required this.name,
      required this.imageUrl,
      this.width = 117.0,
      this.height = 140.0});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductItem && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

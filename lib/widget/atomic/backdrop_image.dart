import 'package:flutter/material.dart';

class BackDrop extends StatelessWidget {
  final String imageUrl;
  const BackDrop({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage(
                        imageUrl),
                    fit: BoxFit.cover))));
  }
}

import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String imageUrl;

  const MoviePoster({
    super.key,required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 200,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

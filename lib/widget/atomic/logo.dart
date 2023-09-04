import 'package:flutter/material.dart';
import 'package:movie_info/general_helpers/localization/localization.dart';

class Logo extends StatelessWidget {
  final bool isCenter;
  const Logo({super.key, required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.movie,
          size: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8), // Memberikan jarak horizontal sebesar 8 piksel
          child: Text(
            translation(context).appTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
    );
  }
}

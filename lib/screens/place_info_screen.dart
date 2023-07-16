import "package:flutter/material.dart";

import "../model/place.dart";

class PlaceInfoScreen extends StatelessWidget {
  const PlaceInfoScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text(place.name)),
      body: Stack(
        children: [
          Image.file(
            place.imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}

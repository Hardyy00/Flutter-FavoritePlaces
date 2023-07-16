import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/screens/place_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});

  void _changeScreen(BuildContext context, Place place) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => PlaceInfoScreen(place: place)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Place> placesList = ref.watch(placesProvider);
    Widget mainContent = Center(
      child: Text(
        "No Places Added Yet",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (placesList.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (ctx, index) => ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(placesList[index].imageFile),
          ),
          onTap: () {
            _changeScreen(context, placesList[index]);
          },
          title: Text(
            placesList[index].name,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                letterSpacing: 1.7),
          ),
        ),
      );
    }

    return mainContent;
  }
}

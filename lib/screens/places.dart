import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/screens/place_add_screen.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesState();
  }
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> placesLoading;

  @override
  void initState() {
    super.initState();
    placesLoading = ref.read(placesProvider.notifier).loadPlaces();
  }

  void _changeScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PlaceAddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Your Places"),
          actions: [
            IconButton(
              onPressed: () {
                _changeScreen(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: placesLoading,
          builder: ((context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: PlacesList(),
                  );
          }),
        ));
  }
}

import 'dart:io';
import "package:favorite_places/providers/fav_places_provider.dart";
import 'package:favorite_places/widgets/image_input.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:favorite_places/model/place.dart';

class PlaceAddScreen extends ConsumerStatefulWidget {
  const PlaceAddScreen({super.key});

  @override
  ConsumerState<PlaceAddScreen> createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends ConsumerState<PlaceAddScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
            content: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Please Select an image first",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
        return;
      }
      _formKey.currentState!.save();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(title: const Text("Add a Place")),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 1.8),
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Place Name"),
                  ),
                  validator: (newValue) {
                    if (newValue == null ||
                        newValue.isEmpty ||
                        newValue.trim().length <= 1 ||
                        newValue.trim().length > 50)
                      return "Number of character must be between 1 to 50";

                    return null;
                  },
                  onSaved: (newValue) {
                    ref
                        .read(placesProvider.notifier)
                        .addPlace(newValue!, _selectedImage!);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ImageInput(saveTheImage: (path) {
                  _selectedImage = path;
                }),
                // const SizedBox(
                //   height: 14,
                // ),
                // const LocationInput(),
                const SizedBox(
                  height: 14,
                ),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Place"),
                )
              ],
            ),
          ),
        ));
  }
}

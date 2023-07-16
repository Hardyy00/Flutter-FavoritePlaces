import "package:favorite_places/model/place.dart";
import "dart:io";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:path_provider/path_provider.dart' as syspaths;
import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";

Future<Database> get getDatabase async {
  final dbPath = await sql.getDatabasesPath();

  final database = await sql.openDatabase(
    path.join(dbPath, 'flutter.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places( id Text PRIMARY KEY, name Text, imagePath Text)');
    },
    version: 1,
  );

  return database;
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final database = await getDatabase;

    final placesData = await database.query('user_places');

    final List<Place> placesList = placesData
        .map(
          (row) => Place(
            id: row['id'] as String,
            row['name'] as String,
            File(
              row['imagePath'] as String,
            ),
          ),
        )
        .toList();

    state = placesList;
  }

  void addPlace(String name, File imageFile) async {
    final dir = await syspaths.getApplicationDocumentsDirectory();
    final imageBaseName = path.basename(imageFile.path);
    final copiedImage = await imageFile.copy('${dir.path}/$imageBaseName');
    final newPlace = Place(name, copiedImage);

    final database = await getDatabase;

    database.insert('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'imagePath': newPlace.imageFile.path,
    });

    state = [newPlace, ...state];
  }
}

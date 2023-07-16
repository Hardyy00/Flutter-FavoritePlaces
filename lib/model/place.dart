import "package:uuid/uuid.dart";
import 'dart:io';

const uuid = Uuid();

class Place {
  Place(this.name, this.imageFile, {id}) : id = id ?? uuid.v4();

  final String name;
  final String id;
  final File imageFile;
}

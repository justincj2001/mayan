import 'dart:io';

import 'package:hive_flutter/adapters.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  File read(BinaryReader reader) {
    // Read data from binary and deserialize it to create a File object
    String path = reader.read();
    return File(path);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    // Serialize the File object to binary
    writer.write(obj.path);
  }
}
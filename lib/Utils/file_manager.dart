import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<File> saveFile(File file) async {
    String path = await _getPath();
    final String fileName = basename(file.path);
    final File localImage = await file.copy('$path/$fileName');
    return localImage;
  }

  Future<File> getFile(String fileName) async {
    String path = await _getPath();
    return File('$path/$fileName');
  }

  Future<String> _getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
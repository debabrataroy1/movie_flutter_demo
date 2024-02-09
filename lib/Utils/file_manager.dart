import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileManager {
  Future<File> saveFile(File file);
  Future<File?> getFile(String fileName);
}

class PathFileManager implements FileManager {
  @override
  Future<File> saveFile(File file) async {
    String path = await _getPath();
    final String fileName = basename(file.path);
    final File localImage = await file.copy('$path/$fileName');
    return localImage;
  }

  @override
  Future<File?> getFile(String fileName) async {
    if (fileName.isEmpty) {
      return null;
    }
    String path = await _getPath();
    File file = File('$path/$fileName');
    return file.existsSync() ? file : null;
  }

  Future<String> _getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
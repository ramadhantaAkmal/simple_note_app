import 'dart:io';
import 'package:path_provider/path_provider.dart';

class WriteFile {
  Future<String> get localPath async {
    final directory = await getExternalStorageDirectory();

    return directory!.path;
  }

  Future<File> _localFile(String title) async {
    final path = await localPath;
    return File('$path/$title.txt');
  }

  Future<File> writeFile(String title, desc) async {
    final file = await _localFile(title);
    // Write the file
    return file.writeAsString('$desc');
  }
}

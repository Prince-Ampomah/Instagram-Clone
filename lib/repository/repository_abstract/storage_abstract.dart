import 'dart:io';

abstract class StorageContract {
  Future<List<String>> uploadMultipleFiles(
    String folderPath,
    String fileName,
    List<File> images,
  );

  Future<String> uploadFile(String folderPath, String? fileName, File file);

  String getFileName(File file);

  Future<void> deleteFileFromStorage(String path);
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/repository/repository_abstract/storage_abstract.dart';

class StorageImplementation implements StorageContract {
  @override
  Future<String> uploadFile(
      String folderPath, String? fileName, File file) async {
    Reference reference = FirebaseStorage.instance
        .ref('$folderPath/$fileName/${getFileName(file)}');
    try {
      TaskSnapshot storageTaskSnapshot = await reference.putFile(file);
      final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> uploadMultipleFiles(
    String folderPath,
    String fileName,
    List<File> images,
  ) async {
    try {
      List<String> imageUrls = await Future.wait(
        images.map(
          (image) => uploadFile(folderPath, fileName, image),
        ),
      );
      return imageUrls;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  String getFileName(File file) {
    return file.path.split('/').last;
  }

  @override
  Future<void> deleteFileFromStorage(String path) async {
    Reference reference = FirebaseStorage.instance.refFromURL(path);
    return await reference.delete();
  }
}

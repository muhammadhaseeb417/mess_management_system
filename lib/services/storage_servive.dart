import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageServive {
  StorageServive();

  final FirebaseStorage _firebasestorage = FirebaseStorage.instance;

  Future<String?> uploadRecipeImage({
    required File file,
    required String uid,
  }) async {
    try {
      Reference recipeRef = _firebasestorage
          .ref("/users/pfp")
          .child("$uid${p.extension(file.path)}");

      UploadTask TASK = recipeRef.putFile(File(file.path));

      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await TASK.whenComplete(() => null);
      String downloadURL = await snapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

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
          .ref("/mess_recipes/images")
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

  Future<String?> getRecipeImageUrl({String? uid}) async {
    try {
      // Reference to the folder containing the images
      Reference folderRef = _firebasestorage.ref("/mess_recipes/images");

      // List all files in the folder
      ListResult result = await folderRef.listAll();

      // Find the first file that matches the uid
      for (Reference ref in result.items) {
        if (ref.name.startsWith(uid!)) {
          // Fetch and return the download URL
          return await ref.getDownloadURL();
        }
      }

      // If no matching file is found
      print("No file found with uid: $uid");
      return null;
    } catch (e) {
      print("Error fetching URL: $e");
      return null;
    }
  }
}

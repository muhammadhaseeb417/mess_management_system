import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/mess_recipesAndtiming.dart';
import '../pages/authentication/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late final CollectionReference<MessRecipes> _messRecipes;
  late final CollectionReference<UserModel> _userModel;

  DatabaseService() {
    _setupFirebaseRecipeReference();
    _setupFirebaseUserReference();
  }

  void _setupFirebaseRecipeReference() {
    _messRecipes = _firebaseFirestore
        .collection("mess_recipes")
        .withConverter<MessRecipes>(
          fromFirestore: (snapshot, _) => MessRecipes.fromMap(snapshot.data()!),
          toFirestore: (messRecipes, _) => messRecipes.toMap(),
        );
  }

  void _setupFirebaseUserReference() {
    _userModel = _firebaseFirestore
        .collection("uet_students")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );
  }

  Future<void> createUserInFirebase({
    required UserModel user,
  }) async {
    try {
      await _userModel!.doc(user.uid).set(user);
    } catch (e) {
      print("Error creating recipe: $e");
      rethrow; // Throw the error for better debugging
    }
  }

  Future<String> createMessRecipeInFirebase({
    required MessRecipes messRecipes,
  }) async {
    try {
      DocumentReference docRef = await _messRecipes.add(messRecipes);
      await docRef.update({'recipeId': docRef.id});
      return docRef.id; // Return the generated recipe ID
    } catch (e) {
      print("Error creating recipe: $e");
      rethrow; // Throw the error for better debugging
    }
  }

  Future<List<MessRecipes>> getAllRecipes() async {
    try {
      final snapshot = await _messRecipes.get();
      final recipes = snapshot.docs
          .map((doc) {
            try {
              return doc.data();
            } catch (e) {
              print("Error parsing document ${doc.id}: $e");
              return null;
            }
          })
          .where((recipe) => recipe != null)
          .toList();

      return recipes.whereType<MessRecipes>().toList();
    } catch (e) {
      print("Error retrieving recipes: $e");
      return [];
    }
  }

  Future<UserModel> getUser({required String uid}) async {
    final userSnapshot = await _userModel.doc(uid).get();
    return userSnapshot.data()!;
  }
}

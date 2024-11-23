import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mess_recipesAndtiming.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late final CollectionReference<MessRecipes> _messRecipes;

  DatabaseService() {
    _setupFirebaseUserReference();
  }

  void _setupFirebaseUserReference() {
    _messRecipes = _firebaseFirestore
        .collection("mess_recipes")
        .withConverter<MessRecipes>(
          fromFirestore: (snapshot, _) => MessRecipes.fromMap(snapshot.data()!),
          toFirestore: (messRecipes, _) => messRecipes.toMap(),
        );
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
      final recipes = snapshot.docs.map((doc) => doc.data()).toList();
      return recipes;
    } catch (e) {
      print("Error retrieving recipes: $e");
      return []; // Return an empty list on error
    }
  }
}

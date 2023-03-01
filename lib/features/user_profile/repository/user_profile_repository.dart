import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femunity/core/constants/firebase_constants.dart';
import 'package:femunity/core/faliures.dart';
import 'package:femunity/core/providers/firebase_providers.dart';
import 'package:femunity/core/type_defs.dart';
import 'package:femunity/models/community_model.dart';
import 'package:femunity/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  UserProfileRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
      FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/extensions/future_extension.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../../../core/base/result.dart';

part 'auth_data_source.g.dart';

@riverpod
FirebaseAuthDataSource firebaseAuthDataSource(Ref ref) {
  return FirebaseAuthDataSourceImpl();
}

abstract class FirebaseAuthDataSource {
  Future<Result<UserCredential, Exception>> signInAnonymously();

  Future<Result<void, Exception>> registerUser(String nickname);

  Future<Result<User, Exception>> getCurrentUser();

  Future<Result<UserCredential?, Exception>> signOut();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  @override
  Future<Result<UserCredential, Exception>> signInAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously().throwIfTimeOut().toResult<UserCredential>();
  }

  @override
  Future<Result<void, Exception>> registerUser(String nickname) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    user.updateDisplayName(nickname);

    final batch = FirebaseFirestore.instance.batch();

    batch.set(FirebaseFirestore.instance.collection(FirestoreCollection.users.name).doc(user.uid), {
      FirestoreCollection.users.uid.name: user.uid,
      FirestoreCollection.users.nickname.name: nickname,
    }, SetOptions(merge: true));

    batch.set(FirebaseFirestore.instance.collection(FirestoreCollection.rankings.name).doc(user.uid), {
      FirestoreCollection.rankings.uid.name: user.uid,
      FirestoreCollection.rankings.nickname.name: nickname,
      FirestoreCollection.rankings.highScore.name: 0,
      FirestoreCollection.rankings.playCount.name: 0,
      FirestoreCollection.rankings.updatedAt.name: FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return await batch.commit().throwIfTimeOut().toResult();
  }

  @override
  Future<Result<User, Exception>> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    return Success(user);
  }

  @override
  Future<Result<UserCredential?, Exception>> signOut() async {
    return await FirebaseAuth.instance.signOut().throwIfTimeOut().toResult();
  }
}

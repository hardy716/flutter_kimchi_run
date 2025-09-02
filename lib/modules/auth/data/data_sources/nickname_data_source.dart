import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/extensions/future_extension.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../../../core/base/result.dart';

part 'nickname_data_source.g.dart';

@riverpod
FirebaseNicknameDataSource firebaseNicknameDataSource(Ref ref) {
  return FirebaseNicknameDataSourceImpl();
}

abstract class FirebaseNicknameDataSource {
  Future<Result<void, Exception>> checkDuplicateNickname({required String nickname});

  Future<Result<void, Exception>> updateNickname({required String nickname});
}

class FirebaseNicknameDataSourceImpl implements FirebaseNicknameDataSource {
  @override
  Future<Result<void, Exception>> checkDuplicateNickname({required String nickname}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    final db = FirebaseFirestore.instance;
    final nicknameDoc = db.collection(FirestoreCollection.nicknames.name).doc(nickname);

    return await db
        .runTransaction((transaction) async {
          final snap = await transaction.get(nicknameDoc);
          if (snap.exists) throw ();

          transaction.set(nicknameDoc, {'uid': user.uid, "createdAt": FieldValue.serverTimestamp()});
        })
        .throwIfTimeOut()
        .toResult();
  }

  @override
  Future<Result<UserCredential?, Exception>> updateNickname({required String nickname}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    user.updateDisplayName(nickname);

    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.users.name)
        .doc(user.uid)
        .update({FirestoreCollection.users.nickname.name: nickname})
        .throwIfTimeOut()
        .toResult();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/extensions/future_extension.dart';
import '../../../../core/extensions/result_extension.dart';
import '../dto/ranking_user_dto.dart';

part 'ranking_data_source.g.dart';

@riverpod
FirebaseRankingDataSource firebaseRankingDataSource(Ref ref) {
  return FirebaseRankingDataSourceImpl();
}

abstract class FirebaseRankingDataSource {
  Future<Result<RankingUserDto?, Exception>> fetchRankingUserById();

  Future<Result<List<RankingUserDto>, Exception>> fetchTop100RankingUsers();

  // Future<Result<List<RankingUserDto>, Exception>> fetchFriendsRankingUsers({required List<String> friends});

  Future<Result<int, Exception>> fetchHigherRankingUserCount({required int userScore});

  Future<Result<int, Exception>> fetchSameEarlierRankingUserCount({
    required int userScore,
    required Timestamp updatedAt,
  });

  Future<Result<void, Exception>> updateRankingUser({
    required String nickname,
    required int playCount,
    required int highScore,
  });
}

class FirebaseRankingDataSourceImpl implements FirebaseRankingDataSource {
  @override
  Future<Result<RankingUserDto?, Exception>> fetchRankingUserById() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.rankings.name)
        .doc(user.uid)
        .get()
        .throwIfTimeOut()
        .toResult<DocumentSnapshot<Map<String, dynamic>>>()
        .execute(
          onSuccess: (s) {
            if (!s.exists) return Success(null);
            return Success(RankingUserDto.fromDoc(s));
          },
          onFailure: (f) => Failure(f),
        );
  }

  @override
  Future<Result<List<RankingUserDto>, Exception>> fetchTop100RankingUsers() async {
    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.rankings.name)
        .orderBy(FirestoreCollection.rankings.highScore.name, descending: true)
        .orderBy(FirestoreCollection.rankings.updatedAt.name)
        .limit(100)
        .get()
        .throwIfTimeOut()
        .toResult<QuerySnapshot<Map<String, dynamic>>>()
        .execute(
          onSuccess: (s) => Success(s.docs.map((doc) => RankingUserDto.fromDoc(doc)).toList()),
          onFailure: (f) => Failure(f),
        );
  }

  // @override
  // Future<Result<List<RankingUserDto>, Exception>> fetchFriendsRankingUsers({required List<String> friends}) async {
  //   if (friends.isEmpty) return Failure(Exception());
  //
  //   /// NOTE: 논리적 OR 계열(or, in, array-contains-any) 쿼리 제한 (30)
  //   /// https://firebase.google.com/docs/firestore/query-data/queries?utm_source=chatgpt.com&hl=ko#limits_on_or_queries
  //   /// const chunkSize = 30;
  //
  //   final db = FirebaseFirestore.instance;
  //
  //   return await db
  //       .collection(FirestoreCollection.rankings.name)
  //       .where(FieldPath.documentId, whereIn: friends)
  //       .get().throwIfTimeOut().toResult<QuerySnapshot<Map<String, dynamic>>>().execute(
  //       onSuccess: (s) => Success(s.docs.map((doc) => RankingUserDto.fromDoc(doc)).toList()),
  //     onFailure: (f) => Failure(f),
  //   );
  // }

  @override
  Future<Result<int, Exception>> fetchHigherRankingUserCount({required int userScore}) async {
    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.rankings.name)
        .where(FirestoreCollection.rankings.highScore.name, isGreaterThan: userScore)
        .get()
        .throwIfTimeOut()
        .toResult<QuerySnapshot<Map<String, dynamic>>>()
        .execute(onSuccess: (s) => Success(s.docs.length), onFailure: (f) => Failure(f));
  }

  @override
  Future<Result<int, Exception>> fetchSameEarlierRankingUserCount({
    required int userScore,
    required Timestamp updatedAt,
  }) async {
    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.rankings.name)
        .where(FirestoreCollection.rankings.highScore.name, isEqualTo: userScore)
        .where(FirestoreCollection.rankings.updatedAt.name, isLessThan: updatedAt)
        .get()
        .throwIfTimeOut()
        .toResult<QuerySnapshot<Map<String, dynamic>>>()
        .execute(onSuccess: (s) => Success(s.docs.length), onFailure: (f) => Failure(f));
  }

  @override
  Future<Result<void, Exception>> updateRankingUser({
    required String nickname,
    required int playCount,
    required int highScore,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Failure(Exception());

    return await FirebaseFirestore.instance
        .collection(FirestoreCollection.rankings.name)
        .doc(user.uid)
        .set({
          FirestoreCollection.rankings.uid.name: user.uid,
          FirestoreCollection.rankings.nickname.name: nickname,
          FirestoreCollection.rankings.highScore.name: highScore,
          FirestoreCollection.rankings.playCount.name: playCount,
          FirestoreCollection.rankings.updatedAt.name: FieldValue.serverTimestamp(),
        }, SetOptions(merge: true))
        .throwIfTimeOut()
        .toResult();
  }
}

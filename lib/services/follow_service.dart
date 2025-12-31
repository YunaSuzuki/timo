import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;

  Future<bool> isFollowing(String targetUserId) async {
    final doc = await _db
        .collection('users')
        .doc(currentUserId)
        .collection('following')
        .doc(targetUserId)
        .get();

    return doc.exists;
  }

  Future<void> follow(String currentUserId, String targetUserId) async {
    final batch = _db.batch();

    final me = _db.collection('users').doc(currentUserId);
    final target = _db.collection('users').doc(targetUserId);

    // 自分の following に「相手」を追加
    batch.set(me.collection('following').doc(targetUserId), {
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 相手の followers に「自分」を追加
    batch.set(target.collection('followers').doc(currentUserId), {
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  Future<void> unfollow(String currentUserId, String targetUserId) async {
    final batch = _db.batch();

    final me = _db.collection('users').doc(currentUserId);
    final target = _db.collection('users').doc(targetUserId);

    batch.delete(me.collection('following').doc(targetUserId));
    batch.delete(target.collection('followers').doc(currentUserId));

    await batch.commit();
  }
}
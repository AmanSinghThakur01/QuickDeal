import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class FirestoreService {

  final FirebaseFirestore
  _firestore =
      FirebaseFirestore.instance;

  Future<void> saveUser(
      UserModel user,
      ) async {

    final doc = _firestore
        .collection(
      'users',
    )
        .doc(
      user.uid,
    );

    final snap =
    await doc.get();

    await doc.set(

      {

        ...user.toMap(),

        if (!snap.exists)

          'createdAt':

          DateTime
              .now()
              .toString(),

      },

      SetOptions(
        merge: true,
      ),

    );
  }

  Future<UserModel?>
  getUser(
      String uid,
      ) async {

    final doc =

    await _firestore

        .collection(
      'users',
    )

        .doc(
      uid,
    )

        .get();

    if (!doc.exists) {

      return null;
    }

    return UserModel
        .fromMap(

      doc.data()!,

    );
  }

  Future<void>
  updateProfile({

    required String uid,

    required String phone,

    required String address,

  }) async {

    await _firestore

        .collection(
      'users',
    )

        .doc(
      uid,
    )

        .update(

      {

        'phone':
        phone,

        'address':
        address,

      },

    );
  }

  Future<void>
  updatePhoto({

    required String uid,

    required String url,

  }) async {

    await _firestore

        .collection(
      'users',
    )

        .doc(
      uid,
    )

        .update(

      {

        'photoUrl':
        url,

      },

    );
  }
}
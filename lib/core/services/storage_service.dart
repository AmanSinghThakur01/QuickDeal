import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String?> uploadProfilePhoto({

    required String uid,

    required File image,

  }) async {

    try {

      final ref =

      _storage

          .ref()

          .child(
        'profile_images',
      )

          .child(
        '$uid.jpg',
      );

      await ref.putFile(
        image,
      );

      final url =
      await ref.getDownloadURL();

      return url;

    } catch (e) {

      return null;

    }
  }

}
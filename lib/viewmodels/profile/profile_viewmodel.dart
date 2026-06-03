import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/services/firestore_service.dart';
import '../../core/services/storage_service.dart';

import '../../models/user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirestoreService _firestore = FirestoreService();

  final StorageService _storage = StorageService();

  UserModel? user;

  bool isLoading = false;

  Future<void> loadUser(String uid) async {
    isLoading = true;

    notifyListeners();

    user = await _firestore.getUser(uid);

    isLoading = false;

    notifyListeners();
  }

  Future<void> updateProfile({
    required String uid,

    required String phone,

    required String address,
  }) async {
    isLoading = true;

    notifyListeners();

    await _firestore.updateProfile(uid: uid, phone: phone, address: address);

    user = user?.copyWith(phone: phone, address: address);

    isLoading = false;

    notifyListeners();
  }

  Future<void> updatePhoto({required String uid, required File image}) async {
    isLoading = true;

    notifyListeners();

    final url = await _storage.uploadProfilePhoto(uid: uid, image: image);
    print("PHOTO URL => $url");
    if (url != null) {
      await _firestore.updatePhoto(uid: uid, url: url);

      user = user?.copyWith(photoUrl: url);
    }

    isLoading = false;

    notifyListeners();
  }
}

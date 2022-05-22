import 'dart:typed_data';
import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class StorageRepo {
  final _storage = firebase_storage.FirebaseStorage.instance;
  final _authService = AuthService();

  Future<String?> uploadFile(Uint8List file, String path) async {
    try {
      UserModel? user = await _authService.getUser();
      var userId = user!.uid;

      var storageRef = _storage.ref().child("$path/$userId");
      var uploadTask =
          storageRef.putData(file, SettableMetadata(contentType: 'image/jpeg'));
      var completedTask = await uploadTask;
      String downloadUrl = await completedTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> uploadProductFile(Uint8List file) async {
    try {
      var productId = const Uuid().v1();

      var storageRef = _storage.ref().child("products/$productId");
      var uploadTask =
          storageRef.putData(file, SettableMetadata(contentType: 'image/jpeg'));
      var completedTask = await uploadTask;
      String downloadUrl = await completedTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> uploadProfilePicture(Uint8List image) async {
    try {
      final photoUrl = await uploadFile(image, 'admin/profile');
      await _authService.updateUserProfilePic(photoUrl!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

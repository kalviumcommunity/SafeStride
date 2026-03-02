import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return file;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  // Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return file;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  // Upload file to Firebase Storage
  Future<String> uploadFile(XFile file, {String? customFileName}) async {
    try {
      // Generate unique filename
      final fileName = customFileName ?? 
          '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      
      // Create reference
      final ref = _storage.ref().child('uploads/$fileName');
      
      // Upload file
      await ref.putFile(File(file.path));
      
      // Get download URL
      final downloadUrl = await ref.getDownloadURL();
      
      debugPrint('File uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading file: $e');
      rethrow;
    }
  }

  // Upload route image
  Future<String> uploadRouteImage(XFile file, String routeId) async {
    try {
      final fileName = 'routes/${routeId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child(fileName);
      
      await ref.putFile(File(file.path));
      final downloadUrl = await ref.getDownloadURL();
      
      debugPrint('Route image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading route image: $e');
      rethrow;
    }
  }

  // Upload user profile image
  Future<String> uploadProfileImage(XFile file, String userId) async {
    try {
      final fileName = 'users/${userId}_profile.jpg';
      final ref = _storage.ref().child(fileName);
      
      await ref.putFile(File(file.path));
      final downloadUrl = await ref.getDownloadURL();
      
      debugPrint('Profile image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading profile image: $e');
      rethrow;
    }
  }

  // Delete file from Firebase Storage
  Future<void> deleteFile(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      await ref.delete();
      debugPrint('File deleted successfully: $fileUrl');
    } catch (e) {
      debugPrint('Error deleting file: $e');
      rethrow;
    }
  }

  // Get file metadata
  Future<String?> getFileMetadata(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      final metadata = await ref.getMetadata();
      return metadata.contentType;
    } catch (e) {
      debugPrint('Error getting file metadata: $e');
      return null;
    }
  }

  // List all files in a directory
  Future<List<String>> listFiles(String directory) async {
    try {
      final ref = _storage.ref().child(directory);
      final result = await ref.listAll();
      
      final urls = <String>[];
      for (final item in result.items) {
        final url = await item.getDownloadURL();
        urls.add(url);
      }
      
      return urls;
    } catch (e) {
      debugPrint('Error listing files: $e');
      return [];
    }
  }
}

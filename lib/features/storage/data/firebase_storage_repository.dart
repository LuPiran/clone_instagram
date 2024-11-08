import 'dart:io';
import 'dart:typed_data';

import 'package:clone_instagram/features/storage/domain/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository extends StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  /*

  PROFILE PICTURES - upload images to storage
  
  */

  //mobile plataform
  @override
  Future<String?> uploadProlifeImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, "profile_images");
  }

  //Web plataform
  @override
  Future<String?> uploadProlifeImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileByte(fileBytes, fileName, "profile_images");
  }

  /*

  POST IMAGES - upload images to storage
  
  */

  //mobile plataform
  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, "post_images");
  }

  //Web plataform
  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileByte(fileBytes, fileName, "post_images");
  }

  /*

  HELPER METHODS - to uploads files to storage

  */

  //mobile plataforms (file)
  Future<String?> _uploadFile(
      String path, String fileName, String folder) async {
    try {
      //get file
      final file = File(path);

      //find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      //upload
      final uploadTask = await storageRef.putFile(file);

      //get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  //web plataforms (bytes)
  Future<String?> _uploadFileByte(
      Uint8List fileBytes, String fileName, String folder) async {
    try {
      //find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      //upload
      final uploadTask = await storageRef.putData(fileBytes);

      //get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}

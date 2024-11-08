import 'dart:typed_data';

abstract class StorageRepository {
  //upload profile images on mobile plataforms
  Future<String?> uploadProlifeImageMobile(String path, String fileName);

  //upload profile images on web plataforms
  Future<String?> uploadProlifeImageWeb(Uint8List fileBytes, String fileName);

  //upload post images on mobile plataforms
  Future<String?> uploadPostImageMobile(String path, String fileName);

  //upload post images on web plataforms
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);
}

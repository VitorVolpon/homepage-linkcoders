// TODO Implement this library.import 'dart:typed_data';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class ImageDownloader {
  static Future<Uint8List> downloadImage(String imageUrl) async {
    final dio = Dio();
    final response = await dio.get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data);
  }
}

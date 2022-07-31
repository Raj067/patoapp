import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';

uploadImageFile(File imageFile, String uploadURL, BuildContext context) async {
  String accessToken = await storage.read(key: 'access') ?? "";
  // shop ID
  String? activeShop = await storage.read(key: 'activeShop');
  int shopId = int.parse(activeShop ?? '0');
  try {
    
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var uri = Uri.parse('$baseUrl$uploadURL');

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(imageFile.path),
    );
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.headers.addAll(getAuthHeaders(accessToken));
    request.fields['shopId'] = '$shopId';
    var response = await request.send();
    // print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      // print(value);
    });
  } catch (e) {
          // ignore: use_build_context_synchronously
    // Navigator.pop(context);
    showTimeOutMessage(
      context: context,
      builder: (context) => const ModalFitTimeOut(),
    );
  }

}

uploadImageBytes(Uint8List? imageBytes, String uploadURL) async {
  // String accessToken = await storage.read(key: 'access') ?? "";
  // // shop ID
  // String? activeShop = await storage.read(key: 'activeShop');
  // int shopId = int.parse(activeShop ?? '0');

  // // base64Encode(MemoryImage(imageBytes!).bytes);
  // var stream = MemoryImage(imageBytes!).bytes;
  // Stream
  // // stream.cast();
  // var length = MemoryImage(imageBytes).toString().length;

  // var uri = Uri.parse('$baseUrl$uploadURL');

  // var request = http.MultipartRequest("POST", uri);
  // var multipartFile = http.MultipartFile(
  //   'file',
  //   stream,
  //   length,
  // //   filename: basename('my-signature.png'),
  // );
  // //contentType: new MediaType('image', 'png'));

  // request.files.add(multipartFile);
  // request.headers.addAll(getAuthHeaders(accessToken));
  // request.fields['shopId'] = '$shopId';
  // var response = await request.send();
  // // print(response.statusCode);
  // response.stream.transform(utf8.decoder).listen((value) {
  //   // print(value);
  // });
}

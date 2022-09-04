import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';

Future<String> uploadImageFile(
    File imageFile, String uploadURL, BuildContext context) async {
  showPleaseWait(
    context: context,
    builder: (context) => const ModalFit(),
  );
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
    // response.stream.transform(utf8.decoder).listen((value) {
    //   // print(value);
    //   print('\n\n\n');
    //   // print("$imageBaseUrl${jsonDecode(value)['img']}");
    //   // return
    //   // link = "$imageBaseUrl${jsonDecode(value)['img']}";
    //   // print(link);
    // });
    var dt = await http.Response.fromStream(response);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    return "$imageBaseUrl${jsonDecode(dt.body)['img']}";
  } catch (e) {
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    showTimeOutMessage(
      context: context,
      builder: (context) => const ModalFitTimeOut(),
    );
  }
  return '';
}

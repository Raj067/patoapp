          // Card(
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(15),
          //     ),
          //   ),
          //   elevation: 0,
          //   child: Column(
          //     children: [
          //       // Image.asset("assets/images/card.png"),
          //       RepaintBoundary(
          //         key: globalKey,
          //         child: SizedBox(
          //           height: 200,
          //           width: 300,
          //           // color: Colors.green,
          //           child: Stack(
          //             children: [
          //               Positioned(
          //                 top: 0,
          //                 left: 0,
          //                 right: 0,
          //                 bottom: 0,
          //                 child: Image.asset("assets/images/card.png"),
          //               ),
          //               Positioned(
          //                 top: 97,
          //                 // left: 50,
          //                 right: 26,
          //                 bottom: 0,
          //                 child: Text(
          //                   _profileController.myProfile.value.businessName.length > 13
          //                       ? _profileController.myProfile.value.businessName
          //                           .replaceRange(13, null, '...')
          //                       : _profileController.myProfile.value.businessName,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveWhite,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 // top: 95,
          //                 // left: 50,
          //                 right: 26,
          //                 bottom: 50,
          //                 child: Text(
          //                   _profileController.myProfile.value.businessSlogan == ""
          //                       ? "Customer is king"
          //                       : _profileController.myProfile.value.businessSlogan,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveBlack,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 top: 60,
          //                 left: 30,
          //                 // right: 26,
          //                 bottom: 0,
          //                 child: Text(
          //                   _profileController.myProfile.value.businessAddress,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveWhite,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 top: 80,
          //                 left: 30,
          //                 // right: 26,
          //                 bottom: 0,
          //                 child: Text(
          //                   _profileController.myProfile.value.businessPhone,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveWhite,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 top: 100,
          //                 left: 30,
          //                 // right: 26,
          //                 bottom: 0,
          //                 child: Text(
          //                   _profileController.myProfile.value.businessEmail == ""
          //                       ? "Email"
          //                       : _profileController.myProfile.value.businessEmail,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveWhite,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 top: 120,
          //                 left: 30,
          //                 // right: 26,
          //                 bottom: 0,
          //                 child: Text(
          //                   _profileController.myProfile.value.instagramName == ""
          //                       ? "_____"
          //                       : _profileController.myProfile.value.instagramName,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 10,
          //                     color: patowaveWhite,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Container(height: 10),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           ElevatedButton(
          //             style: ButtonStyle(
          //               shape: MaterialStateProperty.all(
          //                 const RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(30),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             onPressed: () {},
          //             child: Row(
          //               children: [
          //                 const Icon(Icons.download, size: 18),
          //                 Container(width: 10),
          //                 const Text("Download"),
          //               ],
          //             ),
          //           ),
          //           ElevatedButton(
          //             style: ButtonStyle(
          //               shape: MaterialStateProperty.all(
          //                 const RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(30),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             onPressed: () async {
          //               final bytes = await capturePng();
          //               final dir = await getApplicationDocumentsDirectory();
          //               final file = File('${dir.path}/card.png');
          //               await file.writeAsBytes(bytes);
          //               await Share.shareFiles(
          //                 [file.path],
          //                 text:
          //                     '${_profileController.myProfile.value.businessName} Business Card',
          //                 subject:
          //                     '${_profileController.myProfile.value.businessName} Business Card',
          //               );
          //             },
          //             child: Row(
          //               children: [
          //                 const Icon(Icons.share, size: 18),
          //                 Container(width: 10),
          //                 const Text("Share"),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(height: 10),
          //     ],
          //   ),
          // ),

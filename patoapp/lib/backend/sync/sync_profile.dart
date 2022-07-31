import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';

class SyncProfile {
  final ProfileController _profileController = Get.put(ProfileController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      var data = await http.get(
        Uri.parse(
          "${baseUrl}api/shop-profile-details/",
        ),
        headers: getAuthHeaders(accessToken),
      );
      if (data.statusCode == 200) {
        for (var dx in jsonDecode(data.body)) {
          ProfileData myData = ProfileData(
            instagramName: dx['instagram_name'] ?? "",
            businessSignature: "",
            businessSlogan: dx['slogan'] ?? "",
            businessLogo: "",
            businessCategory: dx['business_category'] ?? "",
            businessType: dx['business_type'] ?? "",
            businessEmail: dx['email'] ?? "",
            businessPhone: dx['phone'] ?? "",
            businessAddress: dx['address'] ?? "-",
            businessName: dx['name'],
            id: dx['id'],
          );
          // Add data to the database
          try {
            await _profileController.addProfile(myData);
          } catch (e) {
            // else update existing data
            await _profileController.updateProfile(myData);
          }
        }
        // Check if data is present in the
        // server database but not in the local database
        //  == Deleting the data that is no longer stored in the database.
        List<Map<String, dynamic>> profile = await DBHelperProfile.query();
        List<ProfileData> localDb = [];
        localDb.addAll(profile
            .map((dx) => ProfileData(
                  instagramName: dx['instagramName'],
                  businessSignature: dx['businessSignature'],
                  businessSlogan: dx['businessSlogan'],
                  businessLogo: dx['businessLogo'],
                  businessCategory: dx['businessCategory'],
                  businessType: dx['businessType'],
                  businessEmail: dx['businessEmail'],
                  businessPhone: "${dx['businessPhone']}",
                  businessAddress: dx['businessAddress'],
                  businessName: dx['businessName'],
                  id: dx['id'],
                ))
            .toList());
        List<dynamic> serverDb =
            jsonDecode(data.body).map((e) => e['id']).toList();
        for (ProfileData dx in localDb) {
          if (!serverDb.contains(dx.id)) {
            // If data present in the local database
            //but not on the server delete it
            await _profileController.deleteProfile(dx);
          }
        }
      }
    } catch (e) {
      // Thereis no internent
    }
  }
}

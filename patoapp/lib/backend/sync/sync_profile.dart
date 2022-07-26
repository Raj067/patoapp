import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/db/db_Profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';

class SyncProfile {
  final ProfileController _profileController = Get.put(ProfileController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";

    var data = await http.get(
      Uri.parse(
        "${baseUrl}api/shop-profile-details/",
      ),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      ProfileData myData = ProfileData(
        instagramSlogan: jsonDecode(data.body)['slogan'],
        businessCategory: jsonDecode(data.body)['business_category'],
        businessType: jsonDecode(data.body)['business_type'],
        instagramName: jsonDecode(data.body)['instagram_name'],
        businessEmail: jsonDecode(data.body)['email'],
        businessAddress: jsonDecode(data.body)['address'],
        businessName: jsonDecode(data.body)['name'],
        id: jsonDecode(data.body)['id'],
      );
      {
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
                instagramSlogan: dx['instagramSlogan'],
                businessCategory: dx['businessCategory'],
                businessType: dx['businessType'],
                instagramName: dx['instagramName'],
                businessEmail: dx['businessEmail'],
                businessAddress: dx['businessAddress'],
                businessName: dx['businessName'],
                id: dx['id'],
              ))
          .toList());
      int serverDb = jsonDecode(data.body)['id'];
      for (ProfileData dx in localDb) {
        if (serverDb != dx.id) {
          // If data present in the local database
          //but not on the server delete it
          await _profileController.deleteProfile(dx);
        }
      }
    }
  }
}

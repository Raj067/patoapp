import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';

class ProfileController extends GetxController {
  Future<int> addProfile(ProfileData profile) async {
    return await DBHelperProfile.insertDb(profile);
  }

  Future<int> updateProfile(ProfileData profile) async {
    return await DBHelperProfile.updateItem(profile);
  }

  Future<void> deleteProfile(ProfileData profile) async {
    await DBHelperProfile.deleteItem(profile);
  }
}

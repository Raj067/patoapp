import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';

class ProfileController extends GetxController {
  var myProfile =
      ProfileData(businessName: 'Loading...', businessAddress: '', id: 0).obs;
  RxList<ProfileData> allProfiles = <ProfileData>[].obs;
  @override
  void onInit() {
    fetchProfileDB();
    super.onInit();
  }

  Future<int> addProfile(ProfileData profile) async {
    return await DBHelperProfile.insertDb(profile);
  }

  Future<int> updateProfile(ProfileData profile) async {
    return await DBHelperProfile.updateItem(profile);
  }

  Future<void> deleteProfile(ProfileData profile) async {
    await DBHelperProfile.deleteItem(profile);
  }

  fetchProfileDB() async {
    List<Map<String, dynamic>> profile = await DBHelperProfile.query();
    List<ProfileData> finalData = [];
    finalData.addAll(profile.map((dx) => fromJsonProfile(dx)).toList());
    allProfiles.value = finalData;
    String? activeShop = await storage.read(key: 'activeShop');

    if (finalData.isNotEmpty) {
      if (activeShop == null) {
        myProfile.value = finalData[0];
      } else {
        int id = int.parse(activeShop);
        myProfile.value = finalData.firstWhere((element) => element.id == id);
      }
    }
  }

  myProfileChangeUpdater(ProfileData profile) {
    myProfile.value = profile;
    update();
  }

  myProfileChangeUpdaterProfile(ProfileData profile) {
    // after successfully updated
    // 1. Update state
    ProfileData oldProfile =
        allProfiles.firstWhere((element) => element.id == profile.id);
    int index = allProfiles.indexOf(oldProfile);
    allProfiles.remove(oldProfile);
    allProfiles.insert(index, profile);
    // Update current profile
    myProfile.value = profile;

    update();
    // 2. Send data to local DB
    updateProfile(profile);
  }

  profileChangeAdd(ProfileData profile) {
    // after successfully updated

    // 1. Update state
    allProfiles.insert(0, profile);
    update();

    // 2. Send data to local DB, so as to update it
    addProfile(profile);
  }
}

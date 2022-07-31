import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_shedule.dart';
import 'package:patoapp/backend/models/shedules.dart';

class SheduleController extends GetxController {
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  var sheduleList = [];

  Future<int> addShedule(SheduleModel shedule) async {
    return await DBHelperShedule.insertDb(shedule);
  }

  Future<int> updateShedule(SheduleModel shedule) async {
    return await DBHelperShedule.updateItem(shedule);
  }

  Future<void> deleteShedule(SheduleModel shedule) async {
    await DBHelperShedule.deleteItem(shedule);
  }
}

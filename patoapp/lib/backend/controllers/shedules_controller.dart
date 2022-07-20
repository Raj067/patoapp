import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_helper.dart';
import 'package:patoapp/backend/models/shedules.dart';

class SheduleController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addShedule(SheduleModel shedule) async {
    return await DBHelper.insertDb(shedule);
  }
}

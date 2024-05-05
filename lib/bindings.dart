

import 'package:get/get.dart';
import 'a_screens/donation/requestsCtr.dart';
import 'auth/authCtr.dart';
import 'generalLayout/generalLayoutCtr.dart';
import 'imagePicker/imageCtr.dart';
import 'mapPicker/mapCtr.dart';


AuthController authCtr = AuthController.instance;
LayoutCtr get layCtr => Get.find<LayoutCtr>();
RequestCtr get reqCtr => Get.find<RequestCtr>();

MapPickerCtr get mapsCtr => Get.find<MapPickerCtr>();
ImagePickerCtr get imgsCtr => Get.find<ImagePickerCtr>();





class GetxBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut<RequestCtr>(() => RequestCtr(),fenix: true);
    Get.lazyPut<MapPickerCtr>(() => MapPickerCtr(),fenix: true);
    Get.lazyPut<ImagePickerCtr>(() => ImagePickerCtr(),fenix: true);

    //Get.lazyPut<FirebaseMessagingCtr>(() => FirebaseMessagingCtr(),fenix: true);
    Get.lazyPut<LayoutCtr>(() => LayoutCtr(),fenix: true);


  }
}
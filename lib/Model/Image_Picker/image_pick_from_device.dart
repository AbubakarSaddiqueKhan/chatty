import 'dart:io';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';

class ImagePickFromDevice {
  static const String cameraSelected = "camera_selected";
  static const String gallerySelected = "gallery_selected";

  static Future<(File? file, String imageName)?> pickImageFromDevice(
      String inputSource) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
        source: inputSource == cameraSelected
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedImage == null) {
      return null;
    }
    String pickedImageName = pickedImage.name;
    File completeSelectedImageFile = File(pickedImage.path);
    developer.log('Picked Image name : $pickedImageName');

    return (completeSelectedImageFile, pickedImageName);
  }
}

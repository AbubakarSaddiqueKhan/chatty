// import 'dart:async';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:chatty/Model/Image_Picker/image_pick_from_device.dart';
// import 'package:meta/meta.dart';

// part 'pick_user_image_from_device_event.dart';
// part 'pick_user_image_from_device_state.dart';

// class PickUserImageFromDeviceBloc
//     extends Bloc<PickUserImageFromDeviceEvent, PickUserImageFromDeviceState> {
//   PickUserImageFromDeviceBloc() : super(PickUserImageFromDeviceInitialState()) {
//     on<FetchImageFromCameraEvent>(_mapFetchImageFromCameraEventToStates);
//     on<FetchImageFromGalleryEvent>(_mapFetchImageFromGalleryEventToStates);
//   }

//   FutureOr<void> _mapFetchImageFromCameraEventToStates(
//       FetchImageFromCameraEvent event,
//       Emitter<PickUserImageFromDeviceState> emit) async {
//     try {
//       emit(PickUserImageFromDeviceLoadingState());

//       File? selectedImage = await ImagePickFromDevice.pickImageFromDevice(
//           ImagePickFromDevice.cameraSelected);

//       emit(PickUserImageFromDeviceLoadedState(pickedImage: selectedImage));
//     } catch (e) {
//       emit(PickUserImageFromDeviceErrorState());
//     }
//   }

//   FutureOr<void> _mapFetchImageFromGalleryEventToStates(
//       FetchImageFromGalleryEvent event,
//       Emitter<PickUserImageFromDeviceState> emit) async {
//     try {
//       emit(PickUserImageFromDeviceLoadingState());
//       File? selectedImage = await ImagePickFromDevice.pickImageFromDevice(
//           ImagePickFromDevice.cameraSelected);

//       emit(PickUserImageFromDeviceLoadedState(pickedImage: selectedImage));
//     } catch (e) {
//       emit(PickUserImageFromDeviceErrorState());
//     }
//   }
// }

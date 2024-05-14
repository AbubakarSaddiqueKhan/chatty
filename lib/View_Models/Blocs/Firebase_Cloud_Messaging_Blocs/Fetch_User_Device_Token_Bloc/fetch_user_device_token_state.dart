part of 'fetch_user_device_token_bloc.dart';

@immutable
sealed class FetchUserDeviceTokenState {
  const FetchUserDeviceTokenState();
}

final class FetchUserDeviceTokenInitialState
    extends FetchUserDeviceTokenState {}

final class FetchUserDeviceTokenLoadingState
    extends FetchUserDeviceTokenState {}

final class FetchUserDeviceTokenLoadedState extends FetchUserDeviceTokenState {
  final String userDeviceToken;

  const FetchUserDeviceTokenLoadedState({required this.userDeviceToken});
}

final class FetchUserDeviceTokenErrorState extends FetchUserDeviceTokenState {}

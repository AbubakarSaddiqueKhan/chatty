// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserContactDetail {
  String userDeviceToken;
  String userFirstName;
  String userLastName;
  String userImageUrl;
  String userPhoneNumber;
  UserContactDetail({
    required this.userDeviceToken,
    required this.userFirstName,
    required this.userLastName,
    required this.userImageUrl,
    required this.userPhoneNumber,
  });

  UserContactDetail copyWith({
    String? userDeviceToken,
    String? userFirstName,
    String? userLastName,
    String? userImageUrl,
    String? userPhoneNumber,
  }) {
    return UserContactDetail(
      userDeviceToken: userDeviceToken ?? this.userDeviceToken,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userDeviceToken': userDeviceToken,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userImageUrl': userImageUrl,
      'userPhoneNumber': userPhoneNumber,
    };
  }

  factory UserContactDetail.fromMap(Map<String, dynamic> map) {
    return UserContactDetail(
      userDeviceToken: map['userDeviceToken'] as String,
      userFirstName: map['userFirstName'] as String,
      userLastName: map['userLastName'] as String,
      userImageUrl: map['userImageUrl'] as String,
      userPhoneNumber: map['userPhoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserContactDetail.fromJson(String source) =>
      UserContactDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserContactDetail(userDeviceToken: $userDeviceToken, userFirstName: $userFirstName, userLastName: $userLastName, userImageUrl: $userImageUrl, userPhoneNumber: $userPhoneNumber)';
  }

  @override
  bool operator ==(covariant UserContactDetail other) {
    if (identical(this, other)) return true;

    return other.userDeviceToken == userDeviceToken &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.userImageUrl == userImageUrl &&
        other.userPhoneNumber == userPhoneNumber;
  }

  @override
  int get hashCode {
    return userDeviceToken.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        userImageUrl.hashCode ^
        userPhoneNumber.hashCode;
  }
}

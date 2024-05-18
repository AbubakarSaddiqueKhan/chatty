// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatDetailModel {
  String senderPhoneNumber;
  String receiverPhoneNumber;
  String message;
  String timeStamp;
  bool isReceivedMessage;
  ChatDetailModel({
    required this.senderPhoneNumber,
    required this.receiverPhoneNumber,
    required this.message,
    required this.timeStamp,
    required this.isReceivedMessage,
  });

  ChatDetailModel copyWith({
    String? senderPhoneNumber,
    String? receiverPhoneNumber,
    String? message,
    String? timeStamp,
    bool? isReceivedMessage,
  }) {
    return ChatDetailModel(
      senderPhoneNumber: senderPhoneNumber ?? this.senderPhoneNumber,
      receiverPhoneNumber: receiverPhoneNumber ?? this.receiverPhoneNumber,
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
      isReceivedMessage: isReceivedMessage ?? this.isReceivedMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderPhoneNumber': senderPhoneNumber,
      'receiverPhoneNumber': receiverPhoneNumber,
      'message': message,
      'timeStamp': timeStamp,
      'isReceivedMessage': isReceivedMessage,
    };
  }

  factory ChatDetailModel.fromMap(Map<String, dynamic> map) {
    return ChatDetailModel(
      senderPhoneNumber: map['senderPhoneNumber'] as String,
      receiverPhoneNumber: map['receiverPhoneNumber'] as String,
      message: map['message'] as String,
      timeStamp: map['timeStamp'] as String,
      isReceivedMessage: map['isReceivedMessage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatDetailModel.fromJson(String source) =>
      ChatDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatDetailModel(senderPhoneNumber: $senderPhoneNumber, receiverPhoneNumber: $receiverPhoneNumber, message: $message, timeStamp: $timeStamp, isReceivedMessage: $isReceivedMessage)';
  }

  @override
  bool operator ==(covariant ChatDetailModel other) {
    if (identical(this, other)) return true;

    return other.senderPhoneNumber == senderPhoneNumber &&
        other.receiverPhoneNumber == receiverPhoneNumber &&
        other.message == message &&
        other.timeStamp == timeStamp &&
        other.isReceivedMessage == isReceivedMessage;
  }

  @override
  int get hashCode {
    return senderPhoneNumber.hashCode ^
        receiverPhoneNumber.hashCode ^
        message.hashCode ^
        timeStamp.hashCode ^
        isReceivedMessage.hashCode;
  }
}

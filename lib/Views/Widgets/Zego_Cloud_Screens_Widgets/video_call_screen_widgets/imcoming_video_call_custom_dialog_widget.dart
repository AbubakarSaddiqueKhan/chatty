import 'package:chatty/View_Models/Custom_Codes/zego_cloud_send_call_invitation_custom_code.dart';
import 'package:flutter/material.dart';

class IncomingCallDialogWidget extends StatelessWidget {
  const IncomingCallDialogWidget(
      {super.key,
      // required this.invitationSenderImageUrl,
      required this.invitationSenderName,
      required this.callId,
      required this.invitationSenderPhoneNumber,
      required this.roomId,
      required this.invitationSenderImageUrl});

  final String invitationSenderName;
  final String callId;
  final String roomId;
  final String invitationSenderPhoneNumber;
  final String? invitationSenderImageUrl;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            child: Container(
              width: width,
              height: height * 0.16,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              invitationSenderName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Incoming Video Call",
                                  style: TextStyle(color: Colors.white38),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (invitationSenderImageUrl != null)
                                        ? NetworkImage(
                                            invitationSenderImageUrl!)
                                        : const AssetImage(
                                            "assets/images/user.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 48,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InkWell(
                              onTap: () {
                                rejectIncomingCallInvitation(
                                    callID: callId, roomId: roomId);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red),
                                alignment: Alignment.center,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 4,
                        ),
                        Expanded(
                          flex: 48,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InkWell(
                              onTap: () {
                                acceptIncomingCallInvitation(
                                    callId: callId,
                                    roomId: roomId,
                                    callerReceiverName: invitationSenderName,
                                    callerReceiverPhoneNumber:
                                        invitationSenderPhoneNumber,
                                    context: context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green),
                                alignment: Alignment.center,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

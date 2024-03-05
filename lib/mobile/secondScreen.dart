import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samplec/colors.dart';
import 'package:samplec/constants.dart';
import 'package:samplec/mobile/model/MessageData.dart';
import 'package:samplec/mobile/model/MyData.dart';
import '../styles.dart';

class SecondScreen extends StatefulWidget {
  final Map<String, dynamic>? connectedUser;
  final MyData? loggedInUser;

  const SecondScreen({super.key, this.connectedUser, this.loggedInUser});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late StreamSubscription<QuerySnapshot> _subscription;
  List<MessageData> messagesList = [];
  TextEditingController message = TextEditingController();
  late String chatId;
  bool typingStatus=true;
  String lastMessageId="";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {

    List<String> mobileNumbers = [widget.connectedUser?["mobileNumber"], widget.loggedInUser!.mobileNumber.toString()];
    mobileNumbers.sort();
    chatId = generateChatId(mobileNumbers[0], mobileNumbers[1]);
    print('CHAT ID:  $chatId ');
    _subscribeToCollectionChanges();
    super.initState();
  }
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
    );
  }

  @override
  void dispose() {
    _unsubscribeFromCollectionChanges();
    _scrollController.dispose();
    super.dispose();
  }
  void _subscribeToCollectionChanges() {
    List<MessageData> dummy = [];
    _subscription = FirebaseFirestore.instance.collection('chats').doc(chatId).collection("messages").snapshots().listen((QuerySnapshot snapshot) {
      dummy.clear();
      messagesList.clear();
      for (var element in snapshot.docs) {
        var data = Map<String, String>.from(element.data() as Map);
        dummy.add(MessageData.fromJson(data));
      }
      setState(() {
        messagesList.addAll(dummy);
        _scrollToBottom();
      });
    });
  }

  void _unsubscribeFromCollectionChanges() {
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            final docRef = FirebaseFirestore.instance.collection("userChat").doc(widget.connectedUser?["id"]);
            docRef.delete();
            final docRef2 = FirebaseFirestore.instance.collection("userChat").doc(widget.loggedInUser?.id);
            docRef2.delete();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Image.asset(
              "assets/images/back.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (messagesList[index].senderId == widget.loggedInUser?.id) {
                      if(messagesList[index].status!="typing") {
                        return senderMessage(messagesList[index].message.toString());
                      }
                    } else if(messagesList[index].senderId == widget.connectedUser!["id"]){
                      if(messagesList[index].status=="typing") {
                        return receiverTypingUi();
                      }
                      return receiverMessage(messagesList[index].message.toString());
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(color: pinkColor, width: 0.5), borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                        onEditingComplete: (){

                        },
                        onChanged: (etcv) {
                          if(typingStatus){
                            lastMessageId = '${DateTime.now().millisecondsSinceEpoch}';
                           typingStatus=false;
                          }else{
                            if(etcv.isEmpty){
                              deleteTypingStatus();
                            }
                          }
                          setTypingStatus(widget.loggedInUser!.id.toString(), widget.connectedUser!["id"],lastMessageId);
                        },
                        controller: message,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(width: 0.5, color: pinkColor),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(width: 0.5, color: Colors.grey),
                          ),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.5, color: pinkColor),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintStyle: ediTextHintStyle(),
                          hintText: "enter message",
                        ),
                        style: ediTextStyle(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.black,
                    onPressed: () {
                      if (message.text != "") {
                        pushMessage(widget.loggedInUser!.id.toString(), widget.connectedUser!["id"]);
                      } else {
                        Constants.showSnackBar(context, "please enter message");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget senderMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        children: [
          Expanded(child: Container()),
          Flexible(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: messageTextStyleSender(),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget receiverMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        children: [
          Flexible(
            flex: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: messageTextStyleSender(),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
  Widget receiverTypingUi() {
    return Row(
      children: [
        Flexible(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Lottie.asset("assets/images/typing_animation.json",width: 70)
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  String generateChatId(String user1Mobile, String user2Mobile) {
    // Concatenate user mobile numbers (or IDs)
    String combined = '$user1Mobile$user2Mobile';

    // Convert the combined string to bytes
    List<int> bytes = utf8.encode(combined);

    // Hash the bytes using SHA-1 algorithm
    Digest hash = sha1.convert(bytes);
    // Convert the hash to a hexadecimal string
    String chatId = hash.toString();
    return chatId;
  }

  void pushMessage(String senderId, String receiverId) {
    MessageData messageData = MessageData();
    messageData.message = message.text;
    messageData.senderId = senderId;
    messageData.receiverId = receiverId;
    messageData.messageId = lastMessageId;
    final docRef = FirebaseFirestore.instance.collection("chats").doc(chatId).collection("messages").doc(messageData.messageId.toString());
    docRef.update(messageData.toJson());
    setState(() {
      message.text = "";
      typingStatus=true;
    });
  }
  void setTypingStatus(String senderId, String receiverId, String lastMessageId) {
    MessageData messageData = MessageData();
    messageData.message = "typing....";
    messageData.senderId = senderId;
    messageData.receiverId = receiverId;
    messageData.messageId = lastMessageId;
    lastMessageId = messageData.messageId.toString();
    final docRef = FirebaseFirestore.instance.collection("chats").doc(chatId).collection("messages").doc(messageData.messageId.toString());
    docRef.set(messageData.toJson());

  }
  void deleteTypingStatus() {
    final docRef = FirebaseFirestore.instance.collection("chats").doc(chatId).collection("messages").doc(lastMessageId);
    print('cksdcmlkdsmc   $docRef');
    // docRef.delete();
    docRef.delete().then((value) {
      print('Document deleted successfully');
    }).catchError((error) {
      print('Failed to delete document: $error');
    });
  }
}

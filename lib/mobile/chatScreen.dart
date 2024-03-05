import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:samplec/colors.dart';
import 'package:samplec/constants.dart';
import 'package:samplec/mobile/homeScreen.dart';
import 'package:samplec/mobile/model/MessageData.dart';
import 'package:samplec/mobile/model/MyData.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../SharedPref.dart';
import '../SocketConnection.dart';
import '../network/genericRepository.dart';
import '../styles.dart';
import 'model/PairedResponse.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic>? pairedUser;

  const ChatScreen({super.key, this.pairedUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<QuerySnapshot> _subscription;
  List<Map<String, dynamic>> messagesList = [];
  TextEditingController message = TextEditingController();
  late String chatId;
  bool typingStatus = true;
  String lastMessageId = "";
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  late MyData? loggedInUser;
  bool backButtonClickedAndOpendAlert = false;
  List<String> messages = [];
  bool typingStatusString = false;
  Timer? _typingTimer;
  bool _isTyping = false;
  @override
  void initState() {
    message.addListener(_onTyping);
    initLoginData();
    socket.on("message", (data) {
      Map<String, dynamic> decodedJson = jsonDecode(data);
      if (!mounted) return;
      setState(() {
        messagesList.add(decodedJson);
         _scrollToBottom();
      });
    });
    socket.on("typingMessage", (data) {
      if(!mounted)return;
      Map<String, dynamic> decodedJson = jsonDecode(data);
      setState(() {
        if (decodedJson["senderId"] != loggedInUser!.id) {
          typingStatusString = decodedJson["status"];
        }

        print('>>> typing');
      });
    });
    socket.on("typingMessageOff", (data) {
      Map<String, dynamic> decodedJson = jsonDecode(data);
      if(!mounted)return;
      setState(() {
        if (decodedJson["senderId"] != loggedInUser!.id) {
          typingStatusString = decodedJson["status"];
        }
      });
    });
    socket.on("leftChatRoomMessage", (data) {
      if (!mounted) return;
      Constants.showSnackBar(context, data);
      Navigator.of(context).pop();
    });
    super.initState();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    message.dispose();

    _scrollController.dispose();
    super.dispose();
  }
  void _onTyping() {
    if (message.text.isNotEmpty && !_isTyping) {
      setState(() {
        _isTyping = true;
        setTypingStatus();
      });
      // Start a timer to detect when the user stops typing
      _typingTimer?.cancel();
      _typingTimer = Timer(Duration(seconds: 2), () {
        setState(() {
          _isTyping = false;
          setTypingStatusOff();
        });
      });
    } else if (message.text.isEmpty && _isTyping) {
      setState(() {
        _isTyping = false;
        setTypingStatusOff();
      });
    }
  }
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Close?'),
        content: const Text('Are you sure,you want to close? no chat history will be available once exited from chat'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              vibrate();
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            // This parameter indicates the action would perform
            // a destructive action such as deletion, and turns
            // the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              vibrate();
              backButtonClickedAndOpendAlert = true;
              socket.emit("leftChatRoom", ({"chatId": chatId}));

              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
              // );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("A Random user",style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),),
                Visibility(visible:typingStatusString,child: Text("typing...",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.normal,color: Colors.grey.shade700)),))
              ],
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // _showAlertDialog(context);
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
                        if (messagesList[index]["senderId"] == loggedInUser!.id) {
                          return senderMessage(messagesList[index]["message"]);
                        } else  {
                          return receiverMessage(messagesList[index]["message"]);
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


                            onEditingComplete: () {},
                            onChanged: (etcv) {
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
                            setTypingStatusOff();
                            pushMessage(loggedInUser!.id.toString(), widget.pairedUser!["id"]);
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
          Container(
            decoration: const BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(

                message,
                style: messageTextStyleSender(color: Colors.white),
                textAlign: TextAlign.start,
                maxLines: 5,

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
          child:
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Lottie.asset("assets/images/typing_animation.json", width: 70)),
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

  void setTypingStatus() {
    MessageData messageData = MessageData();
    messageData.senderId = loggedInUser?.id;
    messageData.chatId = chatId;
    messageData.status = true;
    messageData.receiverId = widget.pairedUser!["id"];
    var encoded = jsonEncode(messageData);
    socket.emit("typing", encoded);
  }
  void setTypingStatusOff() {
    MessageData messageData = MessageData();
    messageData.senderId = loggedInUser?.id;
    messageData.chatId = chatId;
    messageData.status = false;
    messageData.receiverId = widget.pairedUser!["id"];
    var encoded = jsonEncode(messageData);
    socket.emit("typingOff", encoded);
    typingStatus = false;
  }

  void pushMessage(String senderId, String receiverId) {
    MessageData messageData = MessageData();
    messageData.status = false;
    messageData.message = message.text;
    messageData.senderId = senderId;
    messageData.receiverId = receiverId;
    messageData.messageId = lastMessageId;
    messageData.chatId = chatId;
    var encoded = jsonEncode(messageData);
    print('ENCODED >>  $encoded');
    socket.emit("sendMessage", encoded);
    setState(() {
      message.text = "";
      typingStatus = true;
    });
  }

  void initLoginData() async {
    socket = SocketConnection.getSocket()!;
    socket.connect();
    SharedPref sharedPref = SharedPref();
    loggedInUser = MyData.fromJson(await sharedPref.read("user"));
    var mobileNumber1 = widget.pairedUser!["mobileNumber"].toString();
    var mobileNumber2 = loggedInUser!.mobileNumber.toString();
    print('>>>>NUMBERS  $mobileNumber1 $mobileNumber2');
    List<String> mobileNumbers = [mobileNumber1, mobileNumber2];
    mobileNumbers.sort();
    chatId = generateChatId(mobileNumbers[0], mobileNumbers[1]);
    loggedInUser?.chatId = chatId;

    print('>>>>JOIN DATA  ${jsonEncode(loggedInUser)}');

    socket.emit("join", jsonEncode(loggedInUser));

    socket.on("welcomeNote", (data) {
      if (!mounted) return;
      Constants.showSnackBar(context, data);
    });
  }
}

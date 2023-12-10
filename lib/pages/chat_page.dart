import 'package:chat/constens/colors.dart';
import 'package:chat/constens/const_auth.dart';
import 'package:chat/models/message.dart';
import 'package:chat/widgets/chat_buble.dart';
import 'package:chat/widgets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollection);

  final scrollcontroller=ScrollController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Scholer Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy("date").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  
                  return ListView.builder(
                    controller: scrollcontroller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (data[index]["uid"]==FirebaseAuth.instance.currentUser!.uid) {
                        return ChatBuble(
                        message: data[index]["message"], 
                        color: kPrimaryColor, 
                        align: Alignment.centerLeft, 
                        left: Radius.circular(0), 
                        right: Radius.circular(50),
                      );
                      }
                      else{
                        return ChatBuble(
                        message: data[index]["message"], 
                        color: Color.fromRGBO(203, 204, 143, 1), 
                        align: Alignment.centerRight, 
                        left: Radius.circular(50), 
                        right: Radius.circular(0),
                      );
                      }
                      
                    },
                  );
                }
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                  hintText: "send messeg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if(messageController.text.isEmpty){
                          MySnackBar(context, "message is empty");
                        }
                        else{
                           await messages.add(Message(
                            date: DateTime.now(),
                            message: messageController.text,
                            uid: FirebaseAuth.instance.currentUser!.uid
                           ).convertToMap());
                        messageController.clear();

                        scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                        }
                       
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: kPrimaryColor,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kPrimaryColor))),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
  final _firbase = FirebaseFirestore.instance;
  User? signedInUser;
class ChatScreen extends StatefulWidget {
  static const screenRout = '/chat';
  

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
  String? textMessage;

  void curentUser(){
    try{
      final user = _auth.currentUser;
    if(user != null){
      signedInUser = user;
      print(signedInUser!.email);
    }
    }
    catch(e){
      print(e);

    }
  }
  @override
void initState() {
  super.initState();
  curentUser(); // ✅ VERY IMPORTANT
}
// void getmessager()async{
//  final messages=await _firbase.collection('messages').get();
//    for(var message in messages.docs){
//     print(message.data());
//    }
  
// }

// void message()async{
//   await for (var messages in _firbase.collection('messages').snapshots()){ 
//   for(var message in messages.docs ){
//     print(message.data());
//   }
// }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.deepPurpleAccent,
        title: Row(
          children: [
            Image.asset('images/logo1.png',
            height: 40,
            ),
            Text('ChatMe',
            style: TextStyle(
              fontSize: 20,
            ),
            ),
            
          ],

        ),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
            // message();
          }
          , icon: Icon(Icons.close))
        ],
        
      ),
      body: SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         messageStream(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color:  Colors.deepPurpleAccent,
                  width: 1
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value){
                      textMessage = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      hintText: 'write your message here...',
                      border: InputBorder.none
                    ),
                  
                  ),
                ),
                TextButton(
                  onPressed: () {
                messageTextController.clear();
                final user = _auth.currentUser;
                if (user == null) {
                  print('No logged-in user');
                  return;
                }
                _firbase.collection('messages').add({
                  'text': textMessage,
                  'sender': user.email, // ✅ use user directly
                  'time' : FieldValue.serverTimestamp(),
                });
              }
                , child: Text(
                  'send',
                  style: TextStyle(
                    color: Color(0xFF0871B0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ))
              ],
            ),
          )
        ],
      )
      ),
    );
  }

}

class messageStream extends StatelessWidget {
  const messageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: _firbase.collection('messages').orderBy('time').snapshots(),
           builder: (context,snapshot) {
            List<messagwLine> messagesWidged=[];
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            }
            final messages = snapshot.data!.docs.reversed;
            for(var message in messages){
              final messageText = message.get('text');
              final messageEmail = message.get('sender');
              
            final currentUser = signedInUser?.email;
            final  messageWideged=messagwLine(
            text: messageText, 
            sendar: messageEmail,
            isMe: FirebaseAuth.instance.currentUser?.email == messageEmail
            );
                messagesWidged.add(messageWideged);    
            }
            return Expanded(
              child: ListView(
                reverse: true,
                children: 
                messagesWidged
              ,),
            );
           }
           
           );
  }
}

class messagwLine extends StatelessWidget {
  const messagwLine({this.text,this.sendar,required this.isMe, super.key});
  final String? text;
  final String? sendar;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        
        children: [
          Text('$sendar',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black45
          ),),
           Material(
            borderRadius:isMe? BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14)
            ) :BorderRadius.only(
              topRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14)
            ),
              color: isMe? Colors.blue :Colors.deepPurpleAccent,
              child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text('$text'),
              )
              ),
          
        ],
      ),
    );
          
  }
}
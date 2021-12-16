import 'package:firebase_database/firebase_database.dart';

import 'message.dart';

class Message_dao{
  final DatabaseReference message_ref=FirebaseDatabase.instance.reference().child('data');

  void saveMessage(Message_Demo message_demo){
    message_ref.push().set(message_demo.toJson());
  }


  Query getMessageQuery(){
    return message_ref;
  }
}


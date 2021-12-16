import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_to_do_app/Firebase/message.dart';
import 'package:my_to_do_app/Firebase/message_dao.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MessageWidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Message_dao message_dao=new Message_dao();


class _HomeState extends State<Home> {

  TextEditingController controller=TextEditingController();
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  TimeOfDay time=TimeOfDay.now();






  @override
  Widget build(BuildContext context) {


    String getTime_(TimeOfDay time){
      if(time==null){
        return 'Select Time';
      }
      else{
        return "${time.format(context)}";
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do App'),
      ),
      body: Center(child: getMessageList()),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              scrollable: true,
              title: Text('Add a new task'),
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: 'Enter task title',
                        prefixIcon: Icon(
                          Icons.title,
                          size: 30,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: controller2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: 'Enter task description',
                        prefixIcon: Icon(Icons.description),
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: ()
                  {
                    setState(() {
                      if(controller1.text.isEmpty && controller2.text.isEmpty){
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Title is empty!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueGrey[900],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else if(controller1.text.isEmpty){
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Description is empty!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueGrey[900],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else if(controller2.text.isEmpty){
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Please set title and description of task!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueGrey[900],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else{
                        createRecord();
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }


  Widget getMessageList(){
    return Expanded(
        child: FirebaseAnimatedList(
          query: message_dao.getMessageQuery(),
          itemBuilder: (context,snapshot,animation,index){
            final json=snapshot.value as Map<dynamic,dynamic>;
            final message=Message_Demo.fromJson(json);
            return MessageWidget(message.title, message.des);
          },
        ));
  }

  void createRecord(){
    final message=Message_Demo(controller1.text,controller2.text);
    message_dao.saveMessage(message);
    controller1.clear();
    controller2.clear();
  }

}



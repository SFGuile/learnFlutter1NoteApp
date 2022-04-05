import 'package:flutter/material.dart';


List<Widget> todosList = <Widget>[];

void main() => runApp(MaterialApp(
  routes: {
    "/":(context)=> ViewTaskScreen(),
    "/AddTaskScreen":(context)=>AddTaskScreen()

  },
));

class AddTaskScreen extends StatelessWidget{
  addToDo(ToDoWidget toDo,BuildContext context){
    if (toDo.title.isNotEmpty)
    {
      todosList.add(toDo);
      todosList.add(Divider());
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    var nameController= TextEditingController(text: "");
    var messageController=TextEditingController(text: "");

    var setTaskName=Container(padding:EdgeInsets.only(top:18.0),child:TextField(decoration:InputDecoration(labelText: "To do Task Name",hintText: "Enter to do Task Name"),controller: nameController= TextEditingController(text: ""),));
    var setTaskMsg=Container(padding:EdgeInsets.only(top:18.0),child:TextField(decoration:InputDecoration(labelText: "To do Message",hintText: "Enter to do Message"),controller: messageController,));

    var summitBtn=Container(padding:EdgeInsets.only(top:18.0),child:RaisedButton(child: Text("Add Task"),onPressed:() =>

        addToDo( ToDoWidget(
            nameController.text,
            messageController.text,
            DateTime.now()),
            context),
    ));

    var addTaskForm= Column(children: <Widget>[setTaskName,setTaskMsg,summitBtn],);
    return Scaffold(
      appBar: AppBar(title: Text("Add Task"),),
      body: addTaskForm,
    );
  }



}



class ViewTaskScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewTaskScreenState();
  }



}

class ViewTaskScreenState extends State<ViewTaskScreen>{

  @override
  Widget build(BuildContext context) {

    var onNavigationBarTap = (int index) {
      if (index==1)
      {
        Navigator.pushNamed(context, "/AddTaskScreen");
      }
    };

    var bottomNavigationBar = BottomNavigationBar(onTap: onNavigationBarTap, items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),title:Text("要做的清单")),
      BottomNavigationBarItem(icon: Icon(Icons.add),title:Text("添加要做"))
    ],);

    var displayList;
    if (todosList.isNotEmpty){
      displayList=todosList;
    }
    else{
      displayList=[Padding(padding: EdgeInsets.only(top:20.0),child: Text("to do not found"),)];
    }

    return MaterialApp(
        home: Scaffold(
            bottomNavigationBar: bottomNavigationBar,
            appBar: AppBar(title: Text("To-Do List")),
            body: ListView(
              children: <Widget>[
                Container(child: Column(children: displayList))
              ],
            )));
  }
}

class ToDoWidget extends StatefulWidget {
  final String title;
  final String message;
  final DateTime date;

  ToDoWidget(this.title, this.message, this.date);

  @override
  State<StatefulWidget> createState() {
    return ToDoState(this.title, this.message, this.date);
  }
}

class ToDoState extends State<ToDoWidget> {
  String title;
  String message;
  DateTime date;

  ToDoState(this.title, this.message, this.date);

  @override
  Widget build(BuildContext context) {
    String dateString = "Created " +
        this.date.day.toString() +
        "/" +
        this.date.month.toString() +
        "/" +
        this.date.year.toString();

    var message = Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  this.message,
                  style: TextStyle(fontSize: 20.0),
                ))));

    var titleController = TextEditingController(text: this.title);

    var textTitleFieldDecoration = InputDecoration(border: InputBorder.none);

    var textTitleFieldStyle = TextStyle(
        fontSize: 27.0, fontWeight: FontWeight.bold, color: Colors.black);

    var title = TextField(
      controller: titleController,
      decoration: textTitleFieldDecoration,
      style: textTitleFieldStyle,
    );

    var dateCreated =
    Padding(padding: EdgeInsets.only(top: 10.0), child: Text(dateString));

    var todoCard = Column(
      children: <Widget>[title, message, dateCreated],
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    return Container(
        width: 400.0,
        height: 200.0,
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(maxHeight: 200.0, maxWidth: 1000.0),
        padding: EdgeInsets.all(19.0),
        child: todoCard);
  }
}
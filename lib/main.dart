import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //setting colorscheme
  Color background = Color(0xFFD4E6B5);
  Color background2 = Color(0xFFE2D686);
  Color accent1 = Color(0xFFAFC97E);
  Color accent2 = Color(0xFFFFDF64);
  Color text = Color(0xFF877B66);
  Color text2 = Colors.black;

  //keeps track of what the user types
  final _textController = TextEditingController();
  //this list is full of booleans for each task, marking whether the task is completed or not
  List taskChecked = [];

  //keeps track of styling for text based on whether the checkbox has been checked or not
  List taskCrossOut = [];

  //this list is for tasks, every new task is added to the list
  List taskList = [];

  //add function, adds task that are in textfield
  void addTask(String text) {
    setState(() {
      //if the text field is empty, no task can be created
      if (_textController.text.isNotEmpty) {
        taskList.add(text);
        taskChecked.add(false);
        taskCrossOut.add(TextDecoration.none);
        _textController.clear();
      }
    });
  }

  //deletes tasks once delete button is selected
  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
      taskChecked.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2,
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          // Your custom font
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text Box for New Task
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter New Task',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  //when you press X, the text is cleared for the task
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Add Button
            ElevatedButton(
              onPressed: () {
                addTask(_textController.text);
              },
              style: ElevatedButton.styleFrom(backgroundColor: accent1),
              child: Text("Add", style: TextStyle(color: text2)),
            ),
            Divider(
              height: 100,
              color: accent1,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            //ListView
            Expanded(
              child: ListView.separated(
                //every time a new task is added to list, a new list item is created with the following criteria
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //task name
                    title: Text(
                      taskList[index],
                      //here is where text is crossed out
                      style: TextStyle(decoration: taskCrossOut[index]),
                    ),
                    tileColor: accent2,
                    onTap: () {
                      setState(() {
                        //when you tap task, checkbox is changed
                        taskChecked[index] = !taskChecked[index];
                        crossOut(index);
                      });
                    },
                    //creates checkbox
                    leading: Checkbox(
                      value: taskChecked[index],
                      activeColor: accent1,
                      onChanged: (checked) {
                        setState(() {
                          taskChecked[index] = checked;
                          crossOut(index);
                        });
                      },
                    ),
                    //creates delete button
                    trailing: IconButton(
                      onPressed: () {
                        deleteTask(index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                //seperator between each task
                separatorBuilder:
                    (BuildContext context, int index) =>
                        const SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //This method crosses out task if the checkbox is selected
  void crossOut(int index) {
    if (!taskChecked[index]) {
      taskCrossOut[index] = TextDecoration.none;
    } else {
      taskCrossOut[index] = TextDecoration.lineThrough;
    }
  }
}

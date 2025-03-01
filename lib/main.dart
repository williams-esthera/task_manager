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
      title: 'My Calc App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Calc App'),
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
  Color background = Color(0xFFD4E6B5);
  Color background2 = Color(0xFFE2D686);
  Color accent1 = Color(0xFFAFC97E);
  Color accent2 = Color(0xFFFFDF64);
  Color text = Color(0xFF877B66);
  Color text2 = Colors.black;

  //keeps track of what the user types
  final _textController = TextEditingController();
  bool? isChecked = false;
  String userTask = '';
  List taskList = [];

  void addTask(String text) {
    setState((){
      if (_textController.text.isNotEmpty){
      taskList.add(text);
      _textController.clear();
      }
    });
  }

  void deleteTask() {
    setState((){

    });
  }

  void checkTask() {
    setState((){

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
          fontSize: 50,
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
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  bool? taskChecked = false;
                  return ListTile(
                    title: Text(taskList[index]),
                    tileColor: accent2,
                    onTap: () {},
                    leading: Checkbox(
                      value: taskChecked,
                      activeColor: accent2,
                      tristate: true,
                      onChanged: (checked) {
                        setState(() {
                          taskChecked = checked;
                        });
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteTask();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
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
}

import 'package:flutter/material.dart';
import 'package:todo/ListItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'TodoApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TodoItem {
  String title;
  bool status;

  TodoItem({this.title, this.status = false});
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List _items = List<TodoItem>();
  List _itemsDone = List<TodoItem>();
  final textController = TextEditingController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  void _addTodoItem(TodoItem item) {
    setState(() {
      _items.add(item);
    });
  }

  void _addDoneItem(int index, bool status) {
    setState(() {
      var item = _items[index];
      item.status = true;
      _itemsDone.add(item);
      _items.removeRange(index, index + 1);
    });
  }

  Widget _renderItemsList(List list) {
    return (Center(
      child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(
              status: list[index].status,
              title: list[index].title,
              onChanged: (val) {
                _addDoneItem(index, val);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider()),
    ));
  }

  Future<void> _openDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Nova Tarefa'),
            children: <Widget>[
              SimpleDialogOption(
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  onChanged: (String val) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Adicionar Tarefa',
                  ),
                ),
              ),
              SimpleDialogOption(
                child: FlatButton(
                  child: Text('Adicionar'),
                  onPressed: () {
                    var item = TodoItem(title: textController.text);
                    _addTodoItem(item);
                    textController.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: "Tarefas"),
            Tab(text: "Arquivadas"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: _renderItemsList(_items),
          ),
          Center(
            child: _renderItemsList(_itemsDone),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openDialog(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

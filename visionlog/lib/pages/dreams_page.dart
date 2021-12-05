import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DreamsPage extends StatefulWidget {
  DreamsPage({Key? key}) : super(key: key);

  @override
  _DreamsPageState createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dreams'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDreamWidget,
        tooltip: 'Add Dream',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDreamWidget() async {
    var dream = await Navigator.pushNamed(context, '/addDream');

    print('New item: $dream');
  }

  Future<void> _showDreamEntreeWidget(argument) async {
    await Navigator.pushNamed(context, '/dreamEntree',
        arguments: (argument));
  }


}

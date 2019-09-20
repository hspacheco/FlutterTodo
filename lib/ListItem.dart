import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum Action { edit, delete }

class ListItem extends StatelessWidget {
  ListItem({this.status, this.title, @required this.onChanged});
  final bool status;
  final String title;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return (
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: status,
                      onChanged: onChanged),
                  Text(
                    title,
                    style: status
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ],
              ),
              margin: EdgeInsets.only(right: 6),
            ),
            PopupMenuButton<Action>(
              onSelected: (Action result) {},
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<Action>>[
                const PopupMenuItem<Action>(
                  value: Action.edit,
                  child: ListTile(leading: Icon(Icons.edit), title: Text('Editar')),
                ),
                const PopupMenuItem<Action>(
                  value: Action.delete,
                  child: ListTile(leading: Icon(Icons.delete), title: Text('Apagar')),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
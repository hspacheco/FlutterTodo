import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum Action { edit, delete, add }
typedef ButtonActions<T> = void Function(T val);

class ListItem extends StatelessWidget {
  ListItem({this.status, this.title, @required this.onChanged, this.onEdit, this.onDelete});
  final bool status;
  final String title;
  final ValueChanged<bool> onChanged;
  final void Function() onEdit;
  final void Function() onDelete;

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
            !status ? PopupMenuButton<Action>(
              onSelected: (Action result) {
                if (result == Action.edit) {
                  onEdit();
                } else {
                  onDelete();
                }
              },
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
            ) : Container()
          ],
        ),
      )
    );
  }
}
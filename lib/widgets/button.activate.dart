import 'package:flutter/material.dart';

class ButtonActivate extends StatelessWidget {
  const ButtonActivate(
      {Key key, this.onPress, this.color, this.text, this.icon})
      : super(key: key);
  final VoidCallback onPress;
  final Color color;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        onPressed: onPress,
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          leading: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
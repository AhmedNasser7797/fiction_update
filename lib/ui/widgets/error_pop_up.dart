import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class ErrorPopUp extends StatelessWidget {
  final String message;
  final String? title;

  const ErrorPopUp({
    Key? key,
    required this.message,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? "Error!"),
      content: Column(
        children: <Widget>[
          const SizedBox(height: 24.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 36.0),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Ok"),
            textColor: Colors.white,
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

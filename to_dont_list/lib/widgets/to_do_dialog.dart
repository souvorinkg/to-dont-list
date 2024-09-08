import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value, TextEditingController textConroller);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
            print(valueText);
          });
        },
        controller: _inputController,
        decoration: const InputDecoration(hintText: "type something here"),
      ),
      // there should be a button called "OKButton" that pops the dialog
      actions: <Widget>[
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                ? () {
                    setState(() {
                      widget.onListAdded(_inputController.text, _inputController);  // Use _inputController.text directly
                      Navigator.pop(context);
                    });
                  }
                : null,
                child: const Text('OK') // Disable the button if the text is empty
            );
            
          },
        ),


        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("CancelButton"),
              style: noStyle,
              onPressed: () {
                Navigator.pop(context);  // Close the dialog without any action
              },
              child: const Text('Cancel'),
            );
          },
        ),
      ],
    );
  }
}



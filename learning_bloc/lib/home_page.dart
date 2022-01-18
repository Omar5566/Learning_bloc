// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
    child: Column(
      children: [
        SizedBox(height: 150,),
        TextFormField(
          controller: inputText,
          style: TextStyle(
            fontSize: 24,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (value) {
            setState(() {
             // value = inputText.text;
            });
          },
          decoration: InputDecoration(
            focusColor: Colors.white,
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,
            hintText: "Email/Mobile",
            labelText: 'Email/Mobile',
          ),
        ),
        SizedBox(height: 50,),


        Text(inputText.text),


        SizedBox(height: 50,),


        Text(StringName(inputText.text)),


      ],
    ),
      ),
      );
  }
  String StringName(String inputText) {
    if (inputText.length < 5) {
      return inputText;
    } else {
      return inputText.substring(0, 5) + '...';
    }
}
}
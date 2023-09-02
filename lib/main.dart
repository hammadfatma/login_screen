import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          hintText: "Enter your username",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          hintText: "Enter your password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red, // foreground
                        ),
                        onPressed: () {
                          print("Successfully, login");
                        },
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}


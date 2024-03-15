import 'package:flutter/material.dart';

class UserEntryPage extends StatelessWidget {
  Map? userObject;
  UserEntryPage({this.userObject}) {
    nameController.text = userObject != null ? userObject!['Name'] : '';
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('${userObject != null ? 'Edit' : 'Add'} User'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (userObject == null) {
                  userObject = {};
                }
                userObject!['Name'] = nameController.text.toString();
                Navigator.of(context).pop(userObject);
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}

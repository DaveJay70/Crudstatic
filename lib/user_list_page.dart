import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:crudstatic/user_entry_page.dart';

class UserListPage extends StatefulWidget {
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<dynamic> userNameList = [
    {'id': 1, 'Name': 'Jay'},
    {'id': 2, 'Name': 'Yash'},
    {'id': 3, 'Name': 'Jayesh'},
    {'id': 4, 'Name': 'Mohit'},
    {'id': 5, 'Name': 'Parth'}
  ];

  List<dynamic> filterList = [];

  @override
  void initState() {
    super.initState();
    filterList.addAll(userNameList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('User List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return UserEntryPage();
                },
              )).then((value) {
                if (value != null) {
                  setState(() {
                    userNameList.add(value);
                    filterList.clear();
                    filterList.addAll(userNameList);
                  });
                }
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBar(
            leading: Icon(Icons.search),
            onChanged: (value) {
              filterList.clear();
              if (value.isNotEmpty) {
                for (int i = 0; i < userNameList.length; i++) {
                  if (userNameList[i]
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    filterList.add(userNameList[i]);
                  }
                }
              } else {
                filterList.addAll(userNameList);
              }
              setState(() {});
            },
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return UserEntryPage(
                          userObject: filterList[index],
                        );
                      },
                    )).then((value) {
                      if (value != null)
                        setState(() {
                          for (int i = 0; i < userNameList.length; i++) {
                            if (userNameList[i]['id'] == value!['id']) {
                              userNameList[i] = value;
                            }
                          }
                          filterList.clear();
                          filterList.addAll(userNameList);
                        });
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              filterList[index]['Name'].toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showAlertDialog(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: filterList.length,
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(index) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Alert!'),
          content: Text('Are you sure want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                userNameList.removeAt(index);
                filterList.clear();
                filterList.addAll(userNameList);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            )
          ],
        );
      },
    );
  }
}

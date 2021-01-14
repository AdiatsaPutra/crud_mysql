import 'dart:convert';

import 'package:crud_mysql/add_data.dart';
import 'package:crud_mysql/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getData() async {
    final response = await http
        .get('http://192.168.1.104:8090/crud_mysql_backend/get_data.php');
    return jsonDecode(response.body);
  }

  void refresh() {
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakery Shop'),
        actions: [
          GestureDetector(
              onTap: () {
                refresh();
              },
              child: Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddDataPage()));
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailPage(
                  index: index,
                  list: list,
                ),
              ),
            );
          },
          child: Card(
            child: ListTile(
              leading: Column(
                children: [
                  Icon(Icons.breakfast_dining),
                  Text(list[index]['kode']),
                ],
              ),
              title: Text(
                list[index]['nama_roti'],
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Harga: ${list[index]['harga']}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                'Sisa Stok: ${list[index]['stok']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:crud_mysql/edit_page.dart';
import 'package:crud_mysql/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  final int index;
  final List list;

  const DetailPage({this.index, this.list});

  @override
  Widget build(BuildContext context) {
    void deleteData() async {
      var url = 'http://192.168.1.104:8090/crud_mysql_backend/delete_data.php';
      await http.post(url, body: {"id": list[index]['id']});
    }

    void confirmDelete() {
      AlertDialog alertDialog = AlertDialog(
        content:
            Text('Are You Sure Want To Delete ${list[index]['nama_roti']}?'),
        actions: [
          RaisedButton(
              child: Text('Delete'),
              onPressed: () {
                deleteData();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              }),
          RaisedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      );
      showDialog(context: context, child: alertDialog);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${list[index]['nama_roti']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kode Roti: ${list[index]['kode']}',
                ),
                Text(
                  'Nama Roti: ${list[index]['nama_roti']}',
                ),
                Text(
                  'Harga Roti: ${list[index]['harga']}',
                ),
                Text(
                  'Stok Roti: ${list[index]['stok']}',
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        color: Colors.yellow,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => EditPage(
                                    index: index,
                                    list: list,
                                  )));
                        }),
                    RaisedButton(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          confirmDelete();
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

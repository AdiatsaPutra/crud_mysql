import 'package:crud_mysql/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final List list;
  final int index;

  EditPage({this.list, this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController kodeController;
  TextEditingController namaRotiController;
  TextEditingController hargaController;
  TextEditingController stokController;
  void editData() {
    String url = 'http://192.168.1.104:8090/crud_mysql_backend/edit_data.php';
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "kode": kodeController.text,
      "nama_roti": namaRotiController.text,
      "harga": hargaController.text,
      "stok": stokController.text
    });
  }

  @override
  void initState() {
    kodeController =
        TextEditingController(text: widget.list[widget.index]['kode']);
    namaRotiController =
        TextEditingController(text: widget.list[widget.index]['nama_roti']);
    hargaController =
        TextEditingController(text: widget.list[widget.index]['harga']);
    stokController =
        TextEditingController(text: widget.list[widget.index]['stok']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              controller: kodeController,
              decoration: InputDecoration(labelText: 'Kode Roti'),
            ),
            TextField(
              controller: namaRotiController,
              decoration: InputDecoration(labelText: 'Nama Roti'),
            ),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Roti'),
            ),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Stok Roti'),
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Edit Data',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    editData();
                  });
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                })
          ],
        ),
      ),
    );
  }
}

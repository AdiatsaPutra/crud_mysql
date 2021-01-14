import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final TextEditingController kodeController = TextEditingController();

  final TextEditingController namaRotiController = TextEditingController();

  final TextEditingController hargaController = TextEditingController();

  final TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addData() async {
      String url = 'http://192.168.1.104:8090/crud_mysql_backend/add_data.php';

      await http.post(url, body: {
        "kode": kodeController.text,
        "nama_roti": namaRotiController.text,
        "harga": hargaController.text,
        "stok": stokController.text,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
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
                  'Tambahkan Data',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  addData();
                  Navigator.pop(context);
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}

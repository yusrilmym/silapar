// ignore_for_file: unused_field, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  //inisialize field
  var nomer_apar = TextEditingController();
  var nama_ruangan = TextEditingController();
  var jenis_apar = TextEditingController();
  var satuan = TextEditingController();
  var pengisian_awal = TextEditingController();
  var pengisian_akhir = TextEditingController();

  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("https://api-silapar.itrsudcibinong.com/create.php"),
        body: {
          "nomer_apar": nomer_apar.text,
          "nama_ruangan": nama_ruangan.text,
          "jenis_apar": jenis_apar.text,
          "satuan": satuan.text,
          "pengisian_awal": pengisian_awal.text,
          "pengisian_akhir": pengisian_akhir.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/coba', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Data"),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'nomer_apar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nomer_apar,
                  decoration: InputDecoration(
                      hintText: "Nomer Apar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Note nomer_apar is Required!';
                    }
                    return null;
                  },
                ),
                Text(
                  'nama_ruangan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nama_ruangan,
                  decoration: InputDecoration(
                      hintText: "Nama Ruangan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Note Nama Ruangan is Required!';
                    }
                    return null;
                  },
                ),
                Text(
                  'jenis_apar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: jenis_apar,
                  decoration: InputDecoration(
                      hintText: "Jenis Apar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'satuan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: satuan,
                  decoration: InputDecoration(
                      hintText: "Satuan(KG)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pengisian_awal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pengisian_awal,
                  decoration: InputDecoration(
                      hintText: "Tanggal Pengisian Awal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pengisian_akhir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pengisian_akhir,
                  decoration: InputDecoration(
                      hintText: "Tanggal Pengisian Akhir",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //validate
                    if (_formKey.currentState.validate()) {
                      //send data to database with this method
                      _onSubmit();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

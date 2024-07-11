import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas/Home.dart';

class Edit extends StatefulWidget {
  Edit({required this.id});
  String id;
  @override
  State<Edit> createState() => _EditState();
}
class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
//inisialize field
  var title = TextEditingController();
  var content = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          "http://mobilecomputing.my.id/api_anantha/notes/detail.php?id='${widget
              .id}'"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          title = TextEditingController(text: data['judul']);
          content = TextEditingController(text: data['content']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate() async {
    try {
      final response = await http.post(
        Uri.parse("http://mobilecomputing.my.id/api_anantha/notes/update.php"),
        body: {
          "id": widget.id,
          "judul": title.text,
          "content": content.text,
        },
      );
      var data = jsonDecode(response.body);
      print(data["message"]);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Note berhasil diupdate"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home())
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan saat mengupdate note"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future _onDelete() async {
    try {
      final response = await http.post(
        Uri.parse("http://mobilecomputing.my.id/api_anantha/notes/delete.php"),
        body: {
          "id": widget.id,
        },
      );
      var data = jsonDecode(response.body);
      print(data["message"]);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Note berhasil di Hapus"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home())
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan saat menghapus note"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Yakin ingin menghapus note?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check_circle),
                            onPressed: () => _onDelete(),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Judul',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "Masukkan Judul Note",
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
                    if (value!.isEmpty) {
                      return 'Judul Harus di Isi!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Content',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Masukkan Content',
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
                    if (value!.isEmpty) {
                      return 'Content Harus di Isi!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Edit Notes",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
//validate
                    if (_formKey.currentState!.validate()) {
//send data to database with this method
                      _onUpdate();
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
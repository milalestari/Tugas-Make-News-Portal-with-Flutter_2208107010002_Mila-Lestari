import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    this.judul,
    this.content,
    this.datetime,
    this.image,
  });

  final String? judul; // Nullable parameter
  final String? content; // Nullable parameter
  final String? datetime; // Nullable parameter
  final String? image; // Nullable parameter

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: ListView(
            children: [
              Text(
                widget.judul ??
                    'No Title', // Menangani null dengan memberi default value
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                widget.datetime ?? 'No Date Provided', // Menangani null
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              widget.image != null
                  ? Image.network(
                    widget.image!,
                    height: 200,
                  ) // Menangani null untuk image
                  : Container(), // Menampilkan kosong jika image null
              SizedBox(height: 20),
              Text(
                widget.content ?? 'No Content Available',
                textAlign: TextAlign.justify,
              ), // Menangani null
            ],
          ),
        ),
      ),
    );
  }
}

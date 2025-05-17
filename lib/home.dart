import 'package:flutter/material.dart';
import 'detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String linkAPI =
    'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=23be6d9f783a4c719bc99d35310fd79b';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse(linkAPI));
    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  containerBerita(
    String datetime,
    String title,
    String description,
    String image,
  ) {
    return MaterialButton(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailPage(
                  judul: title,
                  content: description,
                  datetime: datetime,
                  image: image,
                ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: 3),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Image.network(image, height: 100),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      datetime,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                    Text(description, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Portal Berita')),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              var article = snapshot.data![i];
              return containerBerita(
                article['publishedAt'],
                article['title'],
                article['description'],
                article['urlToImage'] as String? ??
                    'https://mgmall.s3.amazonaws.com/img/062023/390bed03e54f6440416f0568f61a82b563176996.jpg',
              );
            },
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocero/models/Article.dart';

class ImageListViewState<T extends StatefulWidget> extends State<T> {
  Future<List<ProductListingModel>> _futureNewsData;

  final TextStyle _titleFont =
      TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.8));

  @override
  void initState() {
    super.initState();

    //_futureNewsData = NewsDataService().fetchNewsCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<ProductListingModel>>(
          future: _futureNewsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildNewsData(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
        backgroundColor: Colors.black);
  }

  Widget _buildNewsData(List<ProductListingModel> newsData) {
    return ListView.builder(
        itemCount: newsData.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(newsData[i]);
        });
  }

  Widget _buildRow(ProductListingModel newsData) {
    return Ink(
      child: ListTile(
        title: Text(newsData.title, style: _titleFont),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Image.network(newsData.urlToImage)),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onTap: () {
          //_pushNewsCategory(newsData);
        },
      ),
      color: Colors.grey,
    );
  }
}

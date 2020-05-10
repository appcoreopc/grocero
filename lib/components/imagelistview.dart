import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';

class ImageListViewState<T extends StatefulWidget> extends State<T> {
  Future<List<ProductListingModel>> _futureDataSource;
 
  @override
  void initState() {

    super.initState();
    _futureDataSource = MockDataService.GetProductListing();
  }

  @override
  Widget build(BuildContext context) {

     _futureDataSource = MockDataService.GetProductListing();

    return Scaffold(
        body: FutureBuilder<List<ProductListingModel>>(
          future: _futureDataSource,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildProductListingData(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        backgroundColor: Colors.black);
  }

  Widget _buildProductListingData(List<ProductListingModel> newsData) {
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
        title: Text(newsData.title, style: AppStyle.listViewFontStyle),
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

import 'package:flutter/material.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/checkout/checkoutpage.dart';
import 'package:grocero/home/homepage.dart';
import 'package:grocero/locations/maps/mylocatiopage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productcategory.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/payment/makepayment.dart';
import 'package:grocero/products/productlistpage.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';
import '../Appconstant.dart';

class HomePageState extends State<HomePage> {
  Future<List<ProductListingModel>> _futureDataSource;
  Map<String, int> productCount = Map<String, int>();
  List<ProductListingModel> _productListing;
  Future<List<ProductCategory>> _productCategories;

  @override
  Widget build(BuildContext _context) {
    _futureDataSource = MockDataService.GetProductListing();
    _productCategories = MockDataService.getProductCategories();

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(Appconstant.homePageText),
              backgroundColor: Colors.green[600],
            ),
            body: SafeArea(
                child: Scaffold(
                    body: FutureBuilder<List<ProductListingModel>>(
              future: _futureDataSource,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _productListing = snapshot.data;
                  return _buildProductListingData(_productListing);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ))),
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                this.context,
                CartProduct(productCount, _productListing,
                    NotificationRenderType.none))),
        onGenerateRoute: (settings) {
          if (settings.name == HomePage.routeName) {
            return MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
                maintainState: true,
                fullscreenDialog: false);
          } else if (settings.name == MyLocationPage.routeName) {
            return MaterialPageRoute(
                builder: (BuildContext context) => MyLocationPage(),
                maintainState: true,
                fullscreenDialog: false);
          } else if (settings.name == ProductListingPage.routeName) {
            return MaterialPageRoute(
              builder: (BuildContext context) => ProductListingPage(),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == CartPage.routeName) {
            var cartData = settings.arguments as CartProduct;
            return MaterialPageRoute(
              builder: (BuildContext context) => CartPage(cartData),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == CheckoutPage.routeName) {
            var cartData = settings.arguments as CartProduct;
            return MaterialPageRoute(
              builder: (BuildContext context) => CheckoutPage(cartData),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == MakePaymentPage.routeName) {
            return MaterialPageRoute(
              builder: (BuildContext context) => MakePaymentPage(),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else {
            return null;
          }
        });
  }

  Widget _buildProductListingData(List<ProductListingModel> productLists) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10)),
        Text(
          Appconstant.homePageTopSellingText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productLists.length,
            itemBuilder: (BuildContext context, int index) => Card(
              child: Center(
                  child: Column(children: <Widget>[
                Image.network(productLists[index].urlToImage,
                    height: 200, width: 200),
                Text(productLists[index].title)
              ])),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Text(
          Appconstant.homePageExploreByCategoryText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: FutureBuilder<List<ProductCategory>>(
          future: _productCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildCategoryListView(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )),
      ],
    );
  }

  Widget buildChildLayout(ProductListingModel productListingData) {
    return Row(children: <Widget>[
      Image.network(productListingData.urlToImage, width: 20, height: 20),
      //Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(productListingData.title, style: AppStyle.listViewContentFontStyle),
      // Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      // Text(productListingData.description,
      //     style: AppStyle.listViewContentFontStyle),
      // Text(productListingData.content,
      //     style: AppStyle.listViewContentFontStyle),
      // ButtonBar(
      //   children: <Widget>[
      //     //_buildProductOrderCount(productListingData.title),
      //     FlatButton(
      //       color: Appconstant.appDefaultBackgroundColor,
      //       child: Text(Appconstant.addToCartText),
      //       onPressed: () {
      //         //_addProduct(productListingData.title, 1);
      //       },
      //     ),
      //   ],
      // )
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildCategoryListView(List<ProductCategory> productLists) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: productLists.length,
      itemBuilder: (ctx, index) {
        return Card(
          child: ListTile(
              title: Text(productLists[index].title),
              subtitle: Text(productLists[index].description)),
        );
      },
    );
  }
}

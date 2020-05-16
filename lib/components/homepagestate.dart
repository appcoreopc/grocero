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
  int pageIndex = 0;
  BuildContext bodybc;

  @override
  Widget build(BuildContext context) {
    _futureDataSource = MockDataService.GetProductListing();
    _productCategories = MockDataService.getProductCategories();

    return MaterialApp(
        //navigatorKey: navigatorKey,
        home: Scaffold(
            appBar: AppBar(
                title: Text(Appconstant.homePageText,
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Appconstant.primaryThemeColor),
            body: SafeArea(
                child: Scaffold(
                    body: FutureBuilder<List<ProductListingModel>>(
              future: _futureDataSource,
              builder: (_context, snapshot) {
                if (snapshot.hasData) {
                  bodybc = _context;
                  _productListing = snapshot.data;
                  return _buildTopSellingLayout(_productListing);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ))),
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                context,
                CartProduct(productCount, _productListing,
                    NotificationRenderType.none))),
        //initialRoute: "/",
        //     routes: <String, WidgetBuilder> {

        // '/explore': (BuildContext context) => FirstScreen(),
        // '/explore2': (BuildContext context) => SecondScreen(),
        // '/explore3': (BuildContext context) => FirstScreen(),
        //    },
        //     // '/home': (_context) => SecondScreen(),
        //     // '/explore': (_context) => FirstScreen(),
        //     // '/cart': (_context) => SecondScreen(),
        //   //},
        onGenerateRoute: (settings) {
          // Setup widget routing /////
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

  Widget _buildTopSellingLayout(List<ProductListingModel> productLists) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10)),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  Appconstant.homePageTopSellingText,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: Appconstant.homePageTitleFontSize),
                ))),
        Padding(padding: EdgeInsets.all(4)),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productLists.length,
            itemBuilder: (BuildContext context, int index) => Card(
              child: Center(
                  child: Column(children: <Widget>[
                Image.network(productLists[index].urlToImage,
                    height: 160, width: 180),
                Text(productLists[index].title),
                Text(productLists[index].description,
                    style: TextStyle(
                        color: Appconstant.textColorSecondaryTextColor)),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 4)),
              ])),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  Appconstant.homePageExploreByCategoryText,
                  style: TextStyle(fontSize: Appconstant.homePageTitleFontSize),
                ))),
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
      Text(productListingData.title, style: AppStyle.listViewContentFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildCategoryListView(List<ProductCategory> category) {
    return GridView.count(
      crossAxisCount: Appconstant.gridDefaultColumnSize,
      children: List.generate(category.length, (index) {
        return Center(
            child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(10)),
          Text(
            category[index].title,
            style: Theme.of(context).textTheme.title,
          ),
          Padding(padding: EdgeInsets.all(10)),
          Image.network(category[index].imageUrl, height: 100, width: 100)
        ]));
      }),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen definitely my second screen here ! aahahah"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

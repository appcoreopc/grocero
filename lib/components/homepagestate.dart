import 'package:flutter/material.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/home/homepage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productcategory.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/navigations/route.dart';
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
  BuildContext globalbc;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    _futureDataSource = MockDataService.GetProductListing();
    _productCategories = MockDataService.getProductCategories();

    return MaterialApp(
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
                ///////////////////////////////////////////////////
                // Noticed the build context being assigned here //
                ///////////////////////////////////////////////////
                bodybc = _context;
                _productListing = snapshot.data;
                return _buildTopSellingLayout(_productListing);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ))),
          bottomNavigationBar: createBottomNavigationBar(CartProduct(
              productCount,
              _productListing,
              NotificationRenderType.none,
              pageIndex))
          ),
      onGenerateRoute: AppRoutes.setupRoutes,
    );
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
      Text(productListingData.title,
          style: AppStyle.listViewContentGreyFontStyle),
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

  Widget createBottomNavigationBar(CartProduct cartProduct) {
    Color homeColor = Appconstant.allGreyColor;
    Color exploreColor = Appconstant.allGreyColor;
    Color cartColor = Appconstant.allGreyColor;

    if (cartProduct.navigationBarPageIndex == 0) {
      homeColor = Appconstant.greenColor;
    }

    if (cartProduct.navigationBarPageIndex == 1) {
      exploreColor = Appconstant.greenColor;
    }

    if (cartProduct.navigationBarPageIndex == 2) {
      cartColor = Appconstant.greenColor;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: NavigationHelper.createNotification(Appconstant.homeMenuText,
              Icons.home, NotificationRenderType.none, homeColor),
          title: Text(Appconstant.homeMenuText),
        ),
        BottomNavigationBarItem(
          icon: NavigationHelper.createNotification(Appconstant.exploreMenuText,
              Icons.search, NotificationRenderType.none, exploreColor),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: NavigationHelper.createNotification(
              Appconstant.cartMenuText,
              Icons.shopping_cart,
              cartProduct.notificationRenderType,
              cartColor),
          title: Text(Appconstant.cartMenuText),
        ),
      ],
      currentIndex: cartProduct.navigationBarPageIndex,
      selectedItemColor: Appconstant.greenColor,
      onTap: (idx) => {
        if (idx == 0)
          {NavigationHelper.NavigateTo(bodybc, HomePage.routeName, null)}
        else if (idx == 1)
          {
            NavigationHelper.NavigateTo(
                bodybc, ProductListingPage.routeName, cartProduct)
          }
        else if (idx == 2)
          {
            NavigationHelper.NavigateTo(
                context, CartPage.routeName, cartProduct)
          }
      },
    );
  }
}

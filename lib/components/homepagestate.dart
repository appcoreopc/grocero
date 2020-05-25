import 'package:flutter/material.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/components/grid/gridProductItem.dart';
import 'package:grocero/home/homepage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productcategory.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/navigations/route.dart';
import 'package:grocero/notification/fcmnotification.dart';
import 'package:grocero/products/productlistpage.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';
import 'package:grocero/util/textTruncator.dart';
import '../Appconstant.dart';
import 'grid/gridListType.dart';

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
  void initState() {
    super.initState();
    FcmNotification().registerNotificationHandler(_showItemDialog);
  }

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
                return _buildHomepageLayout(_productListing);
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
              pageIndex))),
      onGenerateRoute: AppRoutes.setupRoutes,
    );
  }

  Widget _buildHomepageLayout(List<ProductListingModel> productLists) {
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
        _buildPaddingWidget(4),
        _buildTopSellersLayout(productLists),
        _buildPaddingWidget(10),
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

  Widget _buildCategoryListView(List<ProductCategory> productCategories) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: productCategories.map((category) {
          return GridDemoPhotoItem(
              photo: category, tileStyle: GridListType.footer);
        }).toList());
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

  Widget _buildPaddingWidget(double paddingValue) {
    return Padding(padding: EdgeInsets.all(paddingValue));
  }

  void _showItemDialog(Map<String, dynamic> message) {
    Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text("Triggering event: chicken_event")));
    // It does show data ///
  }

  Widget _buildTopSellersLayout(List<ProductListingModel> productLists) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productLists.length,
        itemBuilder: (BuildContext context, int index) => Card(
          child: Center(
              child: Column(children: <Widget>[
            Image.network(productLists[index].urlToImage,
                height: 160, width: 180),
            Text(TextUtil.getLayoutFriendlyText(productLists[index].title, 15)),
            Text(
                TextUtil.getLayoutFriendlyText(
                    productLists[index].description, 15),
                style:
                    TextStyle(color: Appconstant.textColorSecondaryTextColor)),
            Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 4)),
          ])),
        ),
      ),
    );
  }
}

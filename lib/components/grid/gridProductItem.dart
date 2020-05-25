import 'package:flutter/material.dart';
import 'package:grocero/models/productcategory.dart';
import 'gridListType.dart';
import 'gridTitleText.dart';

class GridCategoryItem extends StatelessWidget {
  GridCategoryItem(
      {Key key,
      @required this.photo,
      @required this.tileStyle,
      this.onTapFunction})
      : super(key: key);

  final ProductCategory photo;
  final GridListType tileStyle;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: InkResponse(
            child: Image.network(
              photo.imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: onTapFunction)
        );

    switch (tileStyle) {
      case GridListType.imageOnly:
        return image;
      case GridListType.header:
        return GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: GridTitleText(photo.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image,
        );
      case GridListType.footer:
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: GridTitleText(photo.title),
              subtitle: GridTitleText(photo.description),
            ),
          ),
          child: image,
        );
    }
    return null;
  }
}

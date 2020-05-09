
class ProductListingModel {
  final String author;
  final String title;
  String description; 
  String url; 
  String urlToImage;
  String content;
  
  ProductListingModel(this.author, this.title, this.description, this.content, this.urlToImage, this.url);

  // factory Article.fromJson(Map<String, dynamic> json) {
  //   return Article(json['author'], 'b');
  // }
}
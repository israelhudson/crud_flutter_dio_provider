
class Product {
  int id;
  String nameProduct;
  double price;
  int categoryId;
  String thumbnail;
  bool isSelected = false;

  Product(
      this.id,
        this.nameProduct,
        this.price,
        this.categoryId,
        this.thumbnail);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameProduct = json['nameProduct'];
    price = json['price'];
    categoryId = json['categoryId'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameProduct'] = this.nameProduct;
    data['price'] = this.price;
    data['categoryId'] = this.categoryId;
    data['thumbnail'] = this.thumbnail;
    data['isSelected'] = this.isSelected;
    return data;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode * nameProduct.hashCode;

  //int get hashCode => idProduto;

  @override
  bool operator ==(other) => other is Product && other.id == id;
}


//@immutable
//class Product {
//  final int idProduto;
//  final String nameProduct;
//  final double price;
//  final int categoryId;
//  final String thumbnail;
//  bool isSelected;
//  int qtdCart = 1;
//
//  Product(this.idProduto, this.nameProduct, this.price, this.categoryId, this.thumbnail, this.isSelected);
//
//  @override
//  int get hashCode => super.hashCode ^ idProduto.hashCode * nameProduct.hashCode;
//
//  //int get hashCode => idProduto;
//
//  @override
//  bool operator ==(other) => other is Product && other.idProduto == idProduto;
//}
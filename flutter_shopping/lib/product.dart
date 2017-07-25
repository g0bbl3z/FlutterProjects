import 'package:flutter/material.dart';
import 'shopBar.dart';

class Product {
  final String title;
  final String price;
  String image;
  bool network;
  String description;
  bool inCart;

  Product(
      {this.title,
      this.price,
      this.image = "images/default.png",
      this.network = false,
      this.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae volutpat purus. Mauris feugiat, ante sit amet hendrerit imperdiet, lorem ex porttitor ex, et varius metus erat quis felis. Pellentesque eu urna pulvinar, consectetur leo eget, interdum enim. Proin auctor lectus nec metus maximus, at volutpat purus dignissim.",
      this.inCart = true,
      });
  changeCart() {
    this.inCart = !this.inCart;
  }
}

List<Product> products = <Product>[
  new Product(title: "item1", price: "20.00"),
  new Product(title: "item2", price: "12.23"),
  new Product(title: "item3", price: "451.00"),
  new Product(title: "item4", price: "23.23"),
  new Product(title: "item5", price: "67.03"),
  new Product(title: "item6", price: "2.89"),
  new Product(title: "item7", price: "30.00"),
  new Product(title: "item8", price: "46.23"),
  new Product(title: "cat", price: "141.12", image: "images/cat.jpg"),
  new Product(
    title: "dog",
    price: "192.84",
    image: "https://www.what-dog.net/Images/faces2/scroll0015.jpg",
    network: true,
  )
];

class ProductView extends StatelessWidget {
  ProductView({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return new GridTile(
      child: new GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new ProductPage(product);
            },
          ));
        },
        child: new Container(
          decoration: new BoxDecoration(
//              border: new Border.all(),
            color: Colors.grey[300],
//              borderRadius: new BorderRadius.all(const Radius.circular(8.0))
          ),
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Image(
                      image: product.network
                          ? new NetworkImage(product.image)
                          : new AssetImage(product.image),
                      width: 250.0,
                      height: 100.0),
                ),
                new Padding(
                    padding: new EdgeInsets.only(top: 3.0, bottom: 4.0),
                    child: new Text(product.title,
                        style: new TextStyle(fontWeight: FontWeight.bold))),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.attach_money,
                        color: Colors.orangeAccent[400]),
                    new Text(product.price),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<ProductView> generateProductViews(List<Product> products) {
  List<ProductView> productViews = <ProductView>[];
  products.forEach((val) => productViews.add(new ProductView(product: val)));
  return productViews;
}

class ProductPage extends StatefulWidget {
  ProductPage(this.product);

  Product product;

  @override
  _ProductPageState createState() => new _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  RaisedButton createCartButton(Product product) {
    return new RaisedButton(
        onPressed: () {
          widget.product.changeCart();
          setState(() {});
        },
        child: new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 30.0),
            child: new Text(
                !product.inCart ? "Add to Cart" : "Remove from Cart")));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildShopBar(context, widget.product.title),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Flexible(
              child: new Image(
                  image: widget.product.network
                      ? new NetworkImage(widget.product.image)
                      : new AssetImage(widget.product.image))),
          new Row(
            children: <Widget>[
              new Icon(
                Icons.attach_money,
                color: Colors.orangeAccent[400],
                size: 40.0,
              ),
              new Text(widget.product.price,
                  style: new TextStyle(fontSize: 30.0)),
            ],
          ),
          new Container(
              child: new Padding(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: new Text(widget.product.description))),
          createCartButton(widget.product),
          new Padding(padding: new EdgeInsets.only(bottom: 10.0)),
        ],
      ),
    );
  }
}

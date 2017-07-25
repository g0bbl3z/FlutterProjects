import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'product.dart';
import 'shopBar.dart';

class cartPage extends StatefulWidget {
  static String routeName = "cart";

  @override
  _cartPageState createState() => new _cartPageState();
}

List<Product> getProductsInCart(List<Product> products) {
  List<Product> productsInCart = <Product>[];
  for (Product product in products) {
    if (product.inCart) {
      productsInCart.add(product);
    }
  }
  return productsInCart;
}

class _cartPageState extends State<cartPage> {
  void updateCart(Product product) {
    product.changeCart();
    setState(() {});
  }

  List<StatelessWidget> generateProductCartViews(List<Product> products) {
    List<StatelessWidget> productCartViews = <StatelessWidget>[];
    products.forEach((val) => productCartViews
        .add(new productCartView(product: val, onChanged: updateCart)));
    productCartViews.add(new totalTile());
    return productCartViews;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildShopBar(context, "Your Cart"),
      body: new ListView(
        children: generateProductCartViews(getProductsInCart(products)),
      ),
    );
  }
}

double getCartTotal() {
  List<Product> productsInCart = getProductsInCart(products);
  double total = 0.0;
  for (Product product in productsInCart) {
    total += double.parse(product.price);
  }
  return total;
}

class totalTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(decoration: const BoxDecoration(border: const Border(bottom: const BorderSide())), child: new ListTile(
      title: new Text("Checkout"),
      subtitle: new Row(
        children: <Widget>[
          new Icon(Icons.attach_money, color: Colors.orangeAccent),
          new Text(getCartTotal().toStringAsFixed(2)),
        ],
      ),
      onTap: () => handleCheckout(context),
    ),
    );
  }
}

void handleCheckout(BuildContext context) {
  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Your checkout amount is: " + getCartTotal().toString() + " but there is currently no Apple/Android Pay Plugin. See https://github.com/flutter/flutter/issues/9591")));
}

class productCartView extends StatelessWidget {
  productCartView({@required this.product, @required this.onChanged});
  Product product;
  final ValueChanged<Product> onChanged;

  void _handleTap() {
    onChanged(product);
  }

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration:
          new BoxDecoration(border: new Border(bottom: new BorderSide())),
      child: new Row(children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(4.0),
          child: new Image(
            image: product.network
                ? new NetworkImage(product.image)
                : new AssetImage(product.image),
            width: 80.0,
            height: 80.0,
          ),
        ),
        new Expanded(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(product.title),
              new Row(
                children: <Widget>[
                  new Icon(Icons.attach_money, color: Colors.orangeAccent),
                  new Text(product.price),
                ],
              ),
            ],
          ),
        ),
        new Padding(
            padding: new EdgeInsets.only(right: 10.0),
            child: new IconButton(
              icon: new Icon(Icons.delete, color: Colors.blue[300]),
              onPressed: _handleTap,
              tooltip: "Remove from Cart",
            )),
      ]),
    );
  }
}

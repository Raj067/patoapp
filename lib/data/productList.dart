import 'package:flutter/material.dart';

class SingleProduct {
  String productName;
  String thumbnail;
  String productPrice;
  int quantity;
  bool isOutStock;
  String sellingPrice;
  String purchasesPrice;
  String supplierName;
  String supplierContact;
  int totalItemsSold;
  int addedToCart = 0;
  String id;

  SingleProduct({
    this.productName = "",
    this.thumbnail =
        "https://cdn.pixabay.com/photo/2016/03/18/01/09/cupcake-1264214_960_720.png",
    this.productPrice = "",
    this.quantity = 0,
    this.isOutStock = true,
    this.sellingPrice = "1000",
    this.purchasesPrice = "23000",
    this.totalItemsSold = 90,
    this.supplierName = "Rajabu",
    this.supplierContact = "+255679190720",
    this.addedToCart = 0,
    this.id = '1',
  });
  addNewProductToCart(int num) {
    addedToCart += num;
  }

  adjustProductQuantity(int num) {
    quantity += num;
  }
}

List<SingleProduct> allProductDetails() {
  return [
    SingleProduct(
      productName: "Product 1",
      thumbnail:
          "https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_960_720.jpg",
      productPrice: "67,800",
      quantity: 0,
      isOutStock: false,
      id: '1',
    ),
    SingleProduct(
      productName: "Product 2",
      // thumbnail: "",
      productPrice: "12,000",
      quantity: 90,
      isOutStock: true,
      id: '2',
    ),
    SingleProduct(
      productName: "Product 3",
      // thumbnail: "",
      productPrice: "439",
      quantity: 67,
      isOutStock: false,
      id: '3',
    ),
    SingleProduct(
      productName: "Product 4",
      // thumbnail: "",
      productPrice: "9,000",
      quantity: 78,
      isOutStock: false,
      id: '4',
    ),
    SingleProduct(
      productName: "Product 5",
      // thumbnail: "",
      productPrice: "13,000",
      quantity: 89,
      isOutStock: true,
      id: '5',
    ),
    SingleProduct(
      productName: "Product 6",
      // thumbnail: "",
      productPrice: "902",
      quantity: 55,
      isOutStock: false,
      id: '6',
    ),
    SingleProduct(
      productName: "Product 7",
      // thumbnail: "",
      productPrice: "340",
      quantity: 86,
      isOutStock: true,
      id: '7',
    ),
  ];
}

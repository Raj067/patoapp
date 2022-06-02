import 'package:flutter/material.dart';

class SingleProduct {
  String productName;
  String thumbnail;
  String productPrice;
  int quantity;
  bool isOutStock;
  int id;

  SingleProduct({
    this.productName = "",
    this.thumbnail =
        "https://cdn.pixabay.com/photo/2016/03/18/01/09/cupcake-1264214_960_720.png",
    this.productPrice = "",
    this.quantity = 0,
    this.isOutStock = true,
    this.id = 1,
  });
}

allProductDetails() {
  return [
    SingleProduct(
      productName: "Rajabu",
      // thumbnail: "",
      productPrice: "Mrisho",
      quantity: 0,
      isOutStock: false,
      id: 1,
    ),
    SingleProduct(
      productName: "Salehe",
      // thumbnail: "",
      productPrice: "Mrisho",
      quantity: 90,
      isOutStock: true,
      id: 2,
    ),
    SingleProduct(
      productName: "Ally",
      // thumbnail: "",
      productPrice: "Juma",
      quantity: 67,
      isOutStock: false,
      id: 3,
    ),
    SingleProduct(
      productName: "Mustapha",
      // thumbnail: "",
      productPrice: "Abasi",
      quantity: 78,
      isOutStock: false,
      id: 4,
    ),
    SingleProduct(
      productName: "Jamali",
      // thumbnail: "",
      productPrice: "Mrisho",
      quantity: 89,
      isOutStock: true,
      id: 5,
    ),
    SingleProduct(
      productName: "Ashura",
      // thumbnail: "",
      productPrice: "Shabani",
      quantity: 55,
      isOutStock: false,
      id: 6,
    ),
    SingleProduct(
      productName: "Ally",
      // thumbnail: "",
      productPrice: "Dabaga",
      quantity: 86,
      isOutStock: true,
      id: 7,
    ),
  ];
}

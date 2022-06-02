import 'package:flutter/material.dart';

class SingleProduct {
  String productName;
  String lastName;
  String amount;
  bool isToReceive;
  int id;

  SingleProduct({
    this.productName = "",
    this.lastName = "",
    this.amount = "",
    this.isToReceive = true,
    this.id = 0,
  });
}

allProductDetails() {
  return [
    SingleProduct(
      productName: "Rajabu",
      lastName: "Mrisho",
      amount: "Tsh 27,000",
      isToReceive: false,
      id: 1,
    ),
    SingleProduct(
      productName: "Salehe",
      lastName: "Mrisho",
      amount: "Tsh 30,000",
      isToReceive: true,
      id: 2,
    ),
    SingleProduct(
      productName: "Ally",
      lastName: "Juma",
      amount: "Tsh 27,000",
      isToReceive: false,
      id: 3,
    ),
    SingleProduct(
      productName: "Mustapha",
      lastName: "Abasi",
      amount: "Tsh 2,00",
      isToReceive: false,
      id: 4,
    ),
    SingleProduct(
      productName: "Jamali",
      lastName: "Mrisho",
      amount: "Tsh 10,000",
      isToReceive: true,
      id: 5,
    ),
    SingleProduct(
      productName: "Ashura",
      lastName: "Shabani",
      amount: "Tsh 14,000",
      isToReceive: false,
      id: 6,
    ),
    SingleProduct(
      productName: "Ally",
      lastName: "Dabaga",
      amount: "Tsh 32,000",
      isToReceive: true,
      id: 7,
    ),
  ];
}

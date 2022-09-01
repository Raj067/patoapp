import 'dart:convert';

class SingleInvoice {
  int amountReceived;
  int totalAmount;
  int discount;
  List items;
  String invoiceNo;
  String dueDate;
  int id;
  String description;
  int shopId;
  int customerId;
  String fullName;
  String issuedDate;

  SingleInvoice({
    required this.amountReceived,
    required this.totalAmount,
    required this.discount,
    required this.id,
    required this.shopId,
    required this.dueDate,
    this.description = '',
    required this.customerId,
    required this.items,
    required this.invoiceNo,
    required this.fullName,
    required this.issuedDate,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'customerId': customerId,
      'fullName': fullName.toString(),
      'amountReceived': amountReceived,
      'totalAmount': totalAmount,
      'discount': discount,
      'dueDate': dueDate.toString(),
      'items': jsonEncode(items),
      'invoiceNo': invoiceNo.toString(),
      'description': description.toString(),
      'issuedDate': issuedDate,
    };
  }
}

SingleInvoice fromJsonInvoice(Map<String, dynamic> e) {
  return SingleInvoice(
    id: e['id'],
    shopId: e['shopId'],
    customerId: e['customerId'],
    fullName: e['fullName'].toString(),
    amountReceived: e['amountReceived'],
    totalAmount: e['totalAmount'],
    discount: e['discount'],
    dueDate: "${e['dueDate']}",
    items: jsonDecode(e['items']),
    invoiceNo: "${e['invoiceNo']}".toString(),
    description: e['description'].toString(),
    issuedDate: e['issuedDate'],
  );
}

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
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'customerId': customerId,
      'fullName': fullName,
      'amountReceived': amountReceived,
      'totalAmount': totalAmount,
      'discount': discount,
      'dueDate': dueDate,
      'items': jsonEncode(items),
      'invoiceNo': invoiceNo,
      'description': description,
    };
  }
}

SingleInvoice fromJsonInvoice(Map<String, dynamic> e) {
  return SingleInvoice(
    id: e['id'],
    shopId: e['shopId'],
    customerId: e['customerId'],
    fullName: e['fullName'],
    amountReceived: e['amountReceived'],
    totalAmount: e['totalAmount'],
    discount: e['discount'],
    dueDate: "${e['dueDate']}",
    items: jsonDecode(e['items']),
    invoiceNo: "${e['invoiceNo']}",
    description: e['description'],
  );
}

class SingleInvoice {
  int amountReceived;
  int discount;
  List items;
  String invoiceNo;
  String dueDate;
  int id;
  String description;
  int shopId;
  int customerId;

  SingleInvoice({
    required this.amountReceived,
    required this.discount,
    required this.id,
    required this.shopId,
    required this.dueDate,
    this.description = '',
    required this.customerId,
    required this.items,
    required this.invoiceNo,
  });
}

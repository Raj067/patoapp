class BusinessFinancial {
  String date;
  String income;
  String expenses;
  String purchases;
  String sales;
  String id;

  BusinessFinancial({
    this.date = "",
    this.income = "12,000",
    this.expenses = "0",
    this.sales = "90",
    this.purchases = "80%",
    this.id = '1',
  });
}

allBusinessFinancialData() {
  return [
    BusinessFinancial(
      date: "01/01/2020",
      income: "89,00",
      expenses: "12,000",
      sales: "670",
      purchases: "8100",
      id: '1',
    ),
    BusinessFinancial(
      date: "02/01/2020",
      expenses: "9,000",
      income: "23,000",
      sales: "900",
      purchases: "900",
      id: '2',
    ),
    BusinessFinancial(
      date: "03/01/2020",
      expenses: "6,000",
      income: "4,500",
      sales: "9070",
      purchases: "6500",
      id: '3',
    ),
    BusinessFinancial(
      date: "04/01/2020",
      income: "7,689",
      expenses: "708",
      sales: "200",
      purchases: "7100",
      id: '4',
    ),
  ];
}

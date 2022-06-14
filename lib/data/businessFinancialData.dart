class BusinessFinancial {
  String time;
  int price;
  String description;
  String name;
  bool isIncome;
  String id;
  // DateTime date;

  BusinessFinancial({
    this.time = "",
    this.price = 0,
    this.description = "-",
    this.name = "-",
    this.isIncome = true,
    this.id = '1',
  });
}

allBusinessFinancialData() {
  return [
    [
      "01/01/2020",
      "Tsh. 8900",
      "Tsh. 7890",
      [
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Rajabu Mrisho",
          description: "Sale",
          isIncome: true,
          id: '1',
        ),
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 1",
          description: "Description",
          isIncome: false,
          id: '1',
        ),
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 2",
          description: "Description",
          isIncome: true,
          id: '1',
        ),
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 3",
          description: "Description",
          isIncome: true,
          id: '1',
        ),
      ]
    ],
    [
      "02/01/2020",
      "Tsh. 8900",
      "Tsh. 7890",
      [
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 4",
          description: "Description",
          isIncome: false,
          id: '1',
        ),
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 5",
          description: "Description",
          isIncome: true,
          id: '1',
        ),
      ]
    ],
    [
      "02/01/2020",
      "Tsh. 8900",
      "Tsh. 7890",
      [
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 6",
          description: "Description",
          isIncome: false,
          id: '1',
        ),
        BusinessFinancial(
          time: "11:89 PM",
          price: 67000,
          name: "Name 7",
          description: "Description",
          isIncome: false,
          id: '1',
        ),
      ]
    ],
  ];
}

class BusinessGeneral {
  String salesWeek;
  String expensesWeek;
  String profitWeek;
  String salesMonth;
  String expensesMonth;
  String profitMonth;

  BusinessGeneral({
    this.salesWeek = "43,000",
    this.expensesWeek = "12,000",
    this.profitWeek = "54,000",
    this.salesMonth = "9,000",
    this.expensesMonth = "78,900",
    this.profitMonth = '65000',
  });
}

BusinessGeneral businessGeneral = BusinessGeneral();

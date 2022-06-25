// class FinancialData {
//   String id = "1";
//   int totalSales = 0;
//   int totalExpenses = 0;
//   List<Map> data = [{}];
//   DateTime date = DateTime.now();
//   FinancialData({
//     required String id,
//     required int totalSales,
//     required int totalExpenses,
//     required List<Map> data,
//     required DateTime date,
//   });
// }

// allFinancialData() {
//   return [
//     FinancialData(
//       id: "1",
//       totalSales: 10400,
//       totalExpenses: 2300,
//       data: [
//         {
//           "name": "Cash Sale",
//           "description": "4 colgate",
//           "price": "6000",
//         },
//       ],
//       date: DateTime.now(),
//     )
//   ];
// }

class BusinessFinancial {
  String time;
  int price;
  String description;
  String name;
  bool isIncome;
  String id;
  // DateTime date;

  BusinessFinancial({
    required this.time,
    this.price = 0,
    this.description = "-",
    this.name = "-",
    this.isIncome = true,
    this.id = '1',
  });
  deleteTransaction() {
    // print("hello raj -> deleted");
  }
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
// Activity 20/06/2022
// Cash Sale = 4 colgate = sh 6000
// Cash sale = 2 Doffi = sh 2000
// Anitha (cash sale) = 2kg sembe = sh 2400
// Rashidi (invoice) = 2 jamaa. 2 colgate = 6400
// Expenses = breakfast 800
// Expense = Lunch sh 1500
// Close day = Total sale 10,400 = total expenses 2300

// Activity 21/06/2022
// Cash Sale = 3 jamaa = sh 2100
// Cash sale = 2 omo = sh 5000
// cash sale = 3 Nido = sh 9000
// Rashidi (payment-in) = sh 2,400 = Balance due sh 4400
// Expenses = breakfast 800
// Bus fair = breakfast 1000
// Close day = Total sale 18,500 = total expenses 1800

// Activity 22/06/2022
// Cash Sale = 2 jamaa = sh 1400
// Cash sale = 6 omo = sh 15000
// Jumanne (cash sale) = 5 colgate = sh 12500
// Rashidi (payment-in) = sh 4400
// Expense = Purchase (OMO 4 bags) = sh 8000
// Expenses = breakfast 800
// Bus fair = breakfast 1000
// Day Book = Total sale 33,300 = total expenses 9800

// Activity 23/06/2022
// Cash Sale = 3 jamaa = sh 2100
// Cash Sale = 1 jamaa = sh 700
// Cash sale = 2 omo = sh 5000
// Jumanne (cash sale) = 1 omo = sh 2500
// Rashidi (Sale invoice) = 4kg sembe = sh 4800
// Expense = Purchase (jamaa 2 bars) = sh 900
// Expenses = breakfast 800
// expenses = lucnh 1500
// Close day = Total sale 10,300 = total expenses 3200

// Activity 24/06/2022
// Cash Sale = 3 colgate = sh 7500
// Cash Sale = 1 jamaa = sh 700
// Cash sale = 2 omo = sh 5000
// Vivian (cash sale) = 2 omo = sh 5000
// Rashidi (payment-in) = sh 2000 = balance due sh 2800
// Expenses = breakfast sh 800
// Lunch = breakfast sh 1500
// Close day = Total sale sh 20,200 = total expenses 2300

// Closing Balances Inventory as at 24/06/2022

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

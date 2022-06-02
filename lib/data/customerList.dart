class SingleCustomer {
  String firstName;
  String lastName;
  String amount;
  bool isToReceive;
  int id;
  String phoneNumber;

  SingleCustomer({
    this.firstName = "",
    this.lastName = "",
    this.amount = "",
    this.isToReceive = true,
    this.id = 0,
    this.phoneNumber = "",
  });
}

allCustomerDetails() {
  return [
    SingleCustomer(
      firstName: "Rajabu",
      lastName: "Mrisho",
      amount: "Tsh 27,000",
      isToReceive: false,
      phoneNumber: "255679190720",
      id: 1,
    ),
    SingleCustomer(
      firstName: "Salehe",
      lastName: "Mrisho",
      amount: "Tsh 30,000",
      isToReceive: true,
      phoneNumber: "255679190721",
      id: 2,
    ),
    SingleCustomer(
      firstName: "Ally",
      lastName: "Juma",
      amount: "Tsh 27,000",
      isToReceive: false,
      phoneNumber: "255679190722",
      id: 3,
    ),
    SingleCustomer(
      firstName: "Mustapha",
      lastName: "Abasi",
      amount: "Tsh 2,00",
      isToReceive: false,
      phoneNumber: "255679190723",
      id: 4,
    ),
    SingleCustomer(
      firstName: "Jamali",
      lastName: "Mrisho",
      amount: "Tsh 10,000",
      isToReceive: true,
      phoneNumber: "255679190724",
      id: 5,
    ),
    SingleCustomer(
      firstName: "Ashura",
      lastName: "Shabani",
      amount: "Tsh 14,000",
      isToReceive: false,
      phoneNumber: "255679190725",
      id: 6,
    ),
    SingleCustomer(
      firstName: "Ally",
      lastName: "Dabaga",
      amount: "Tsh 32,000",
      isToReceive: true,
      phoneNumber: "255679190726",
      id: 7,
    ),
  ];
}

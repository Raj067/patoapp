class SingleCustomer {
  String fullName;
  String email;
  String amount;
  bool isToReceive;
  int id;
  String phoneNumber;

  SingleCustomer({
    this.fullName = "",
    this.email = "",
    this.amount = "",
    this.isToReceive = true,
    this.id = 0,
    this.phoneNumber = "",
  });
}

allCustomerDetails() {
  return [
    SingleCustomer(
      fullName: "Rajabu",
      email: "Mrisho",
      amount: "Tsh 27,000",
      isToReceive: false,
      phoneNumber: "255679190720",
      id: 1,
    ),
    SingleCustomer(
      fullName: "Salehe",
      email: "Mrisho",
      amount: "Tsh 30,000",
      isToReceive: true,
      phoneNumber: "255679190721",
      id: 2,
    ),
    SingleCustomer(
      fullName: "Ally",
      email: "Juma",
      amount: "Tsh 27,000",
      isToReceive: false,
      phoneNumber: "255679190722",
      id: 3,
    ),
    SingleCustomer(
      fullName: "Mustapha",
      email: "Abasi",
      amount: "Tsh 2,00",
      isToReceive: false,
      phoneNumber: "255679190723",
      id: 4,
    ),
    SingleCustomer(
      fullName: "Jamali",
      email: "Mrisho",
      amount: "Tsh 10,000",
      isToReceive: true,
      phoneNumber: "255679190724",
      id: 5,
    ),
    SingleCustomer(
      fullName: "Ashura",
      email: "Shabani",
      amount: "Tsh 14,000",
      isToReceive: false,
      phoneNumber: "255679190725",
      id: 6,
    ),
    SingleCustomer(
      fullName: "Ally",
      email: "Dabaga",
      amount: "Tsh 32,000",
      isToReceive: true,
      phoneNumber: "255679190726",
      id: 7,
    ),
  ];
}

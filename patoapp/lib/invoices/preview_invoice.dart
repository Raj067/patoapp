// import 'package:flutter/material.dart';
// import 'package:patoapp/data/customer_list.dart';
// import 'package:patoapp/themes/light_theme.dart';

// // ignore: must_be_immutable
// class PreviewInvoice extends StatefulWidget {
//   SingleCustomer customer;
//   PreviewInvoice({Key? key, required this.customer}) : super(key: key);

//   @override
//   State<PreviewInvoice> createState() => _PreviewInvoiceState();
// }

// class _PreviewInvoiceState extends State<PreviewInvoice> {
//   // final List _myColors = [Colors.green, Colors.red, Colors.blue];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: const Text(
//         //   'Feedback',
//         //   style: TextStyle(color: Colors.white),
//         // ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: patowaveWhite,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.settings,
//               color: patowaveWhite,
//             ),
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text("Single Invoice"),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: patowavePrimary,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.print),
//             label: 'Print',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.edit),
//             label: 'Edit',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.delete),
//             label: 'Delete',
//           ),
//         ],
//         // currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         // onTap: _onItemTapped,
//         unselectedItemColor: Colors.white,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }

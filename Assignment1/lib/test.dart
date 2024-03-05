// class Section extends StatelessWidget {
//   const Section({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [Text('SectionA'), Text('SectionB')]),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [Text('SectionC'), Text('SectionD')]),
//         ],
//       ),
//     );
//   }
// }

// class Section3 extends StatelessWidget {
//   const Section3({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//         child: Column(children: [
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Project Name',
//             style: TextStyle(fontSize: 20),
//           ),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Year of Implementation',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Fabsta\'s Fashion Magazine',
//             style: TextStyle(fontSize: 20),
//           ),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             '07/2016 - 09/2016',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Blood Bank Management System',
//             style: TextStyle(fontSize: 20),
//           ),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             '06/2017 - 12/2017',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Smart Building System using IoT',
//             style: TextStyle(fontSize: 20),
//           ),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             '08/2018 - 01/2019',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Automated SAP JobSheet Tracking',
//             style: TextStyle(fontSize: 20),
//           )
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             '08/2019 - 10/2019',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'SAP Process Automation with UiPath',
//             style: TextStyle(fontSize: 20),
//           ),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             '03/2021 - 05/2022',
//             style: TextStyle(fontSize: 20),
//           ),
//         ])
//       ]),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('                   '),
//         ]),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('                   '),
//         ])
//       ]),
//     ]));
//   }
// }

// class Section3 extends StatelessWidget {
//   const Section3({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(16.0), // Add padding for spacing
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black, // Choose a color for the border
//             width: 2.0, // Adjust the border width as needed
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Projects:",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0), // Add spacing
//             _buildProjectRow("Fabsta's Fashion Magazine", "07/2016 - 09/2016"),
//             _buildProjectRow(
//                 "Blood Bank Management System", "06/2017 - 12/2017"),
//             _buildProjectRow(
//                 "Smart Building System using IoT", "08/2018 - 01/2019"),
//             _buildProjectRow(
//                 "Automated SAP JobSheet Tracking", "08/2019 - 10/2019"),
//             _buildProjectRow(
//                 "SAP Process Automation with UiPath", "03/2021 - 05/2022"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProjectRow(String projectName, String implementationPeriod) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           projectName,
//           style: TextStyle(fontSize: 20),
//         ),
//         Text(
//           "Time of Implementation: $implementationPeriod",
//           style: TextStyle(fontSize: 20),
//         ),
//         SizedBox(height: 16.0), // Add spacing between projects
//       ],
//     );
//   }
// }

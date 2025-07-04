// import 'dart:typed_data';
//
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// //import 'package:pdf/widgets/theme.dart';
//
// Future<Uint8List> generateDocument(Map datas) async {
// //   var myTheme = ThemeData.withFont(
// //   //  base: Font.ttf(await rootBundle.load("fonts/Poppins-Regular.ttf")),
// //  //   bold: Font.ttf(await rootBundle.load("fonts/Poppins-SemiBold.ttf")),
// //   );
//
//   final pw.Document doc = pw.Document(
//       // theme: myTheme,
//       );
//
//   doc.addPage(pw.MultiPage(
//       pageFormat:
//           PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       header: (pw.Context context) {
//         if (context.pageNumber == 1) {
//           return null;
//         }
//         return pw.Container(
//             alignment: pw.Alignment.centerRight,
//             margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//             padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//             decoration: const pw.BoxDecoration(),
//             child: pw.Text('Portable Document Format',
//                 style: pw.Theme.of(context)
//                     .defaultTextStyle
//                     .copyWith(color: PdfColors.grey)));
//       },
//       build: (pw.Context context) => <pw.Widget>[
//             pw.Header(
//                 level: 0,
//                 title: 'Recepit',
//                 child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: <pw.Widget>[
//                       pw.Text('Proaims Gold Flash', textScaleFactor: 2),
//                       pw.PdfLogo()
//                     ])),
//
//             pw.Paragraph(
//               text: "Name :" '${datas["Name"]}',
//             ),
//             pw.Paragraph(
//               text: "Phone :" '${datas["Phone"]}',
//             ),
//             pw.Paragraph(
//               text: "Transaction id :" '${datas["Transaction id"]}',
//             ),
//             pw.Paragraph(
//               text: "Vocuher number :" '${datas["Vocuher number"]}',
//             ),
//             pw.Paragraph(
//               text: "Registration Number :" '${datas["registrationNumber"]}',
//             ),
//             pw.Paragraph(
//               text: "Subscription Scheme Id :" '${datas["subscriptionId"]}',
//             ),
//             pw.Paragraph(
//               text: "Gold in gram :" '${datas["Gram"]}',
//             ),
//             pw.Paragraph(
//               text: "Amount :" '${datas["amount"]}',
//             ),
//             pw.Paragraph(text: "Payment date :" '${datas["Date"]}'),
//             pw.Paragraph(
//               text: "GST :" '${datas["GST"]}',
//             ),
//             pw.Paragraph(
//               text: "Trade name :" '${datas["Trade Name"]}',
//             ),
//
//             // pw.Table.fromTextArray(
//             //     context: context,
//             //     border: null,
//             //     headerAlignment: pw.Alignment.centerLeft,
//             //     data: <List<String>>[
//             //       <String>['Receipt'],
//             //    //   for (int i = 0; i < datas.length; i++)
//             //         <String>[
//             //           '${datas["Transaction id"]}',
//             //           '${datas["Vocuher number"]}',
//             //           '${datas["Gram"]}',
//             //           '${datas["amount"]}',
//             //           '${datas["Date"]}',
//             //           '${datas["GST"]}',
//             //           '${datas["Trade Name"]}',
//
//             //         ],
//             //     ]),
//             pw.Paragraph(text: ""),
//             pw.Padding(padding: const pw.EdgeInsets.all(10)),
//           ]));
//   return doc.save();
// }

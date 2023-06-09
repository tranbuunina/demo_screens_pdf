// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, library_private_types_in_public_api, library_prefixes

import 'dart:io';
import 'package:demopdf/screens/provider/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';
import 'model/order_model.dart';

class PDFView extends ConsumerStatefulWidget {
  final int id;

  const PDFView({Key? key, required this.id}) : super(key: key);

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends ConsumerState<PDFView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final listDetail = ref
        .watch(OrderRepository.futureOrderDetailProvider(widget.id.toString()));
    return Scaffold(
        appBar: AppBar(title: Text("PDF")),
        body: listDetail.when(
          error: (err, stack) => Text('Error: $err'),
          data: (OrderModel? data) {
            return PdfPreview(
              build: (format) => _createPdf(data),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }

  Future<Uint8List> _createPdf(OrderModel? data) async {
    final ByteData bytes = await rootBundle.load('assets/images/logo.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final ByteData bgImg = await rootBundle.load('assets/images/bg.jpg');
    final Uint8List imageProvider = bgImg.buffer.asUint8List();
    final font_gg_b = await PdfGoogleFonts.robotoBold();
    final font_gg_r = await PdfGoogleFonts.robotoRegular();
    final DateTime now = DateTime.now();
    final listProduct =
        await getProductList(data?.product ?? <Product>[], font_gg_r);
    var footerMultiPageCount = 0;
    final pdf = pdfWid.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );

    pdf.addPage(
      pdfWid.MultiPage(
        pageTheme: pdfWid.PageTheme(
          margin: pdfWid.EdgeInsets.all(40),
          pageFormat: PdfPageFormat.a4,
          buildBackground: (context) {
            return pdfWid.Opacity(
              opacity: 0.3,
              child: pdfWid.Container(
                decoration: pdfWid.BoxDecoration(
                  color: PdfColors.white,
                  image: pdfWid.DecorationImage(
                    image: pdfWid.MemoryImage(imageProvider),
                    fit: pdfWid.BoxFit.fitWidth,
                  ),
                ),
              ),
            );
          },
        ),
        build: (context) {
          return [
            pdfWid.Wrap(
              crossAxisAlignment: pdfWid.WrapCrossAlignment.center,
              children: [
                pdfWid.Row(
                  mainAxisAlignment: pdfWid.MainAxisAlignment.start,
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.center,
                  children: [
                    pdfWid.Image(pdfWid.MemoryImage(byteList),
                        fit: pdfWid.BoxFit.fitHeight, height: 125, width: 125),
                    pdfWid.SizedBox(width: 15),
                    pdfWid.Column(
                      mainAxisAlignment: pdfWid.MainAxisAlignment.start,
                      crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                      children: [
                        pdfWid.Text("Sneaker Vietnam",
                            style: pdfWid.TextStyle(
                                font: font_gg_b, fontSize: 20)),
                        pdfWid.SizedBox(height: 5),
                        pdfWid.Row(
                          mainAxisAlignment: pdfWid.MainAxisAlignment.start,
                          crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                          children: [
                            pdfWid.Text("Địa Chỉ:",
                                style: pdfWid.TextStyle(
                                    font: font_gg_b, fontSize: 15)),
                            pdfWid.Container(
                              width: 300,
                              child: pdfWid.Text(
                                  " 425/16 NĐC, Phường 5, Quận 3, TP. HCM",
                                  style: pdfWid.TextStyle(
                                      font: font_gg_r, fontSize: 14),
                                  softWrap: true),
                            )
                          ],
                        ),
                        pdfWid.SizedBox(height: 5),
                        pdfWid.Row(children: [
                          pdfWid.Text("ĐT:",
                              style: pdfWid.TextStyle(
                                  font: font_gg_b, fontSize: 15)),
                          pdfWid.Text(" 0909999999 - 0909999999",
                              style: pdfWid.TextStyle(
                                  font: font_gg_r, fontSize: 14)),
                        ]),
                        pdfWid.SizedBox(height: 5),
                        pdfWid.Row(children: [
                          pdfWid.Text("Email:",
                              style: pdfWid.TextStyle(
                                  font: font_gg_b, fontSize: 15)),
                          pdfWid.Text(" email@gmail.com",
                              style: pdfWid.TextStyle(
                                  font: font_gg_r, fontSize: 14)),
                        ]),
                      ],
                    )
                  ],
                ),
                pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.center,
                  mainAxisAlignment: pdfWid.MainAxisAlignment.center,
                  children: [
                    pdfWid.Container(
                      margin: pdfWid.EdgeInsets.only(top: 30, bottom: 10),
                      child: pdfWid.Text(
                        "HÓA ĐƠN BÁN HÀNG",
                        style: pdfWid.TextStyle(fontSize: 30, font: font_gg_b),
                        textAlign: pdfWid.TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
            pdfWid.Container(
              margin: pdfWid.EdgeInsets.only(bottom: 20),
              child: pdfWid.Row(
                mainAxisAlignment: pdfWid.MainAxisAlignment.center,
                crossAxisAlignment: pdfWid.CrossAxisAlignment.center,
                children: [
                  pdfWid.Text('Ngày:${now.day}',
                      style: pdfWid.TextStyle(font: font_gg_r, fontSize: 15)),
                  pdfWid.SizedBox(width: 10),
                  pdfWid.Text('Tháng: ${now.month}',
                      style: pdfWid.TextStyle(font: font_gg_r, fontSize: 15)),
                  pdfWid.SizedBox(width: 10),
                  pdfWid.Text('Năm: ${now.year}',
                      style: pdfWid.TextStyle(font: font_gg_r, fontSize: 15)),
                ],
              ),
            ),
            pdfWid.Container(
              margin: pdfWid.EdgeInsets.only(bottom: 10),
              child: pdfWid.Column(
                mainAxisAlignment: pdfWid.MainAxisAlignment.start,
                crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                children: [
                  pdfWid.Row(
                    mainAxisAlignment: pdfWid.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                    children: [
                      pdfWid.Row(
                        crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                        children: [
                          pdfWid.Text("Khách Hàng: ",
                              style: pdfWid.TextStyle(
                                  font: font_gg_b, fontSize: 17)),
                          pdfWid.SizedBox(
                            width: 145,
                            child: pdfWid.Text(
                              data!.fullname.toString(),
                              softWrap: true,
                              style: pdfWid.TextStyle(
                                  font: font_gg_r, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                      pdfWid.SizedBox(width: 10),
                      pdfWid.Row(
                        children: [
                          pdfWid.Text("Mã Số Thuế: ",
                              style: pdfWid.TextStyle(
                                  font: font_gg_b, fontSize: 17)),
                          pdfWid.Text("1482926",
                              style: pdfWid.TextStyle(
                                  font: font_gg_r, fontSize: 17)),
                        ],
                      ),
                    ],
                  ),
                  pdfWid.SizedBox(height: 15),
                  pdfWid.Row(
                    crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                    children: [
                      pdfWid.Text("Địa Chỉ: ",
                          style:
                              pdfWid.TextStyle(font: font_gg_b, fontSize: 17)),
                      pdfWid.Container(
                        width: 400,
                        child: pdfWid.Text(
                          data!.address.toString(),
                          style:
                              pdfWid.TextStyle(font: font_gg_r, fontSize: 17),
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                  pdfWid.SizedBox(height: 15),
                  pdfWid.Row(
                    children: [
                      pdfWid.Text("Điện Thoại: ",
                          style:
                              pdfWid.TextStyle(font: font_gg_b, fontSize: 17)),
                      pdfWid.Text(data!.phone.toString(),
                          style:
                              pdfWid.TextStyle(font: font_gg_r, fontSize: 17)),
                    ],
                  ),
                  pdfWid.SizedBox(height: 15),
                  pdfWid.Table(
                      border: pdfWid.TableBorder.all(),
                      defaultVerticalAlignment:
                          pdfWid.TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: pdfWid.FixedColumnWidth(31),
                        1: pdfWid.FixedColumnWidth(45),
                        2: pdfWid.FixedColumnWidth(50),
                        3: pdfWid.FixedColumnWidth(91),
                        4: pdfWid.FixedColumnWidth(33),
                        5: pdfWid.FixedColumnWidth(57),
                        6: pdfWid.FixedColumnWidth(57),
                      },
                      children: [
                        pdfWid.TableRow(
                          children: [
                            pdfTitle("STT", font_gg_b),
                            pdfTitle("MĐH", font_gg_b),
                            pdfTitle("Hình Ảnh", font_gg_b),
                            pdfTitle("Tên Sản Phẩm", font_gg_b),
                            pdfTitle("SL", font_gg_b),
                            pdfTitle("Đơn Giá", font_gg_b),
                            pdfTitle("Thành Tiền", font_gg_b),
                          ],
                        ),
                      ]),
                  pdfWid.Table(
                      border: pdfWid.TableBorder.all(),
                      defaultVerticalAlignment:
                          pdfWid.TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: pdfWid.FixedColumnWidth(31),
                        1: pdfWid.FixedColumnWidth(45),
                        2: pdfWid.FixedColumnWidth(50),
                        3: pdfWid.FixedColumnWidth(91),
                        4: pdfWid.FixedColumnWidth(33),
                        5: pdfWid.FixedColumnWidth(57),
                        6: pdfWid.FixedColumnWidth(57),

                      },
                      children: listProduct),
                  pdfWid.Table(
                    border: pdfWid.TableBorder.all(),
                    defaultVerticalAlignment:
                        pdfWid.TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: pdfWid.FixedColumnWidth(48.7),
                      1: pdfWid.FixedColumnWidth(20.3),
                    },
                    children: [
                      pdfWid.TableRow(
                        children: [
                          pdfWid.Container(
                              child: pdfWid.Text('Thuế VAT 10% (nếu có)',
                                  style: pdfWid.TextStyle(
                                      fontSize: 15, font: font_gg_b),
                                  textAlign: pdfWid.TextAlign.right),
                              margin: pdfWid.EdgeInsets.only(right: 10),
                              padding: pdfWid.EdgeInsets.all(5)),
                          pdfWid.Container(
                            child: pdfWid.Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'vi-VN', decimalDigits: 0)
                                    .format(priceVat(data: data.product)),
                                style: pdfWid.TextStyle(
                                    fontSize: 15, font: font_gg_r),
                                textAlign: pdfWid.TextAlign.right),
                            margin: pdfWid.EdgeInsets.only(right: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pdfWid.Table(
                    border: pdfWid.TableBorder.all(),
                    defaultVerticalAlignment:
                        pdfWid.TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: pdfWid.FixedColumnWidth(48.7),
                      1: pdfWid.FixedColumnWidth(20.3),
                    },
                    children: [
                      pdfWid.TableRow(
                        children: [
                          pdfWid.Container(
                              child: pdfWid.Text('Tổng cộng',
                                  style: pdfWid.TextStyle(
                                      fontSize: 15, font: font_gg_b),
                                  textAlign: pdfWid.TextAlign.right),
                              margin: pdfWid.EdgeInsets.only(right: 10),
                              padding: pdfWid.EdgeInsets.all(5)),
                          pdfWid.Container(
                            child: pdfWid.Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'vi-VN', decimalDigits: 0)
                                    .format(totalPrice(data: data.product) +
                                        priceVat(data: data.product)),
                                style: pdfWid.TextStyle(
                                    fontSize: 15, font: font_gg_r),
                                textAlign: pdfWid.TextAlign.right),
                            margin: pdfWid.EdgeInsets.only(right: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pdfWid.SizedBox(height: 15),
                  pdfWid.Container(
                    child: pdfWid.Column(
                      children: [
                        pdfWid.Text("Khách hàng",
                            textAlign: pdfWid.TextAlign.center,
                            style: pdfWid.TextStyle(
                                font: font_gg_b, fontSize: 15)),
                        pdfWid.Text("(ký & ghi rõ họ tên)",
                            textAlign: pdfWid.TextAlign.center,
                            style:
                                pdfWid.TextStyle(font: font_gg_r, fontSize: 15))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          footerMultiPageCount++;
          return pdfWid.Header(
            level: 3,
            text: 'Page: ${context.pageNumber}',
            textStyle: pdfWid.TextStyle(font: font_gg_r, fontSize: 13),
          );
        },
      ),
    );

    return pdf.save();
  }

  int priceTT(int? va, int? va2) {
    return va! * va2!;
  }

  double priceVat({List<Product>? data}) {
    return totalPrice(data: data) * 0.1;
  }

  double totalPrice({List<Product>? data}) {
    double totalScores = 0.0;
    data?.forEach((element) {
      totalScores += priceTT(int.parse(element.quantity.toString()),
          int.parse(element.regularPrice.toString()));
    });
    return totalScores;
  }

  getProductList(List<Product> products, pdfWid.Font font) async {
    final listProduct = <pdfWid.TableRow>[];
    for (int i = 0; i < products.length; i++) {
      final img = await getImages(data: products[i]);
      final item = pdfWid.TableRow(
        children: [
          pdfTitle((i + 1).toString(), font),
          pdfTitle(products[i].code.toString(), font),
          img,  
          pdfTitle(products[i].name.toString(), font),
          pdfTitle(products[i].quantity.toString(), font),
          pdfTitle(
              NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                  .format(products[i].regularPrice),
              font),
          pdfTitle(
              NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                  .format(
                      priceTT(products[i].regularPrice, products[i].quantity)),
              font),
        ],
      );
      listProduct.add(item);
    }
    return listProduct;
  }
}

Future<pdfWid.Column> getImages({required Product data}) async {
  final netImage = await networkImage(data.photo ?? "");
  return pdfWid.Column(
    crossAxisAlignment: pdfWid.CrossAxisAlignment.center,
    mainAxisAlignment: pdfWid.MainAxisAlignment.center,
    children: [
      pdfWid.Container(
        padding: pdfWid.EdgeInsets.all(5),
        child: pdfWid.Image(netImage,
            width: 60, height: 50, fit: pdfWid.BoxFit.cover),
      ),
    ],
  );
}

pdfWid.Container pdfTitle(String title, pdfWid.Font font_gg_r) {
  return pdfWid.Container(
    padding: pdfWid.EdgeInsets.all(5),
    child: pdfWid.Text(title,
        style: pdfWid.TextStyle(fontSize: 14, font: font_gg_r),
        textAlign: pdfWid.TextAlign.center),
  );
}

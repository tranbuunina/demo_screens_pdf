import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'model/order_model.dart';
import 'order_pdf_screen.dart';
import 'provider/order_repository.dart';


class OrderDetail extends ConsumerStatefulWidget {

  const OrderDetail({Key? key})
      : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends ConsumerState<OrderDetail>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final listDetail = ref
        .watch(OrderRepository.futureOrderDetailProvider("1"));
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng #A001',
            style: const TextStyle(
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
      backgroundColor: const Color(0xffF5F5FA),
      body: listDetail.when(
        error: (err, stack) => Text('Error: $err'),
        data: (OrderModel? data) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Image.asset("assets/images/order_detail.png",
                      fit: BoxFit.cover, width: double.infinity),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 0, left: 8, right: 8, bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data!.orderStatus!.namevi.toString(),
                              style: const TextStyle(
                                  color: Color(0xff222222),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xffFB9116),
                                minimumSize: const Size(100, 30) // NEW,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      PDFView(id: int.parse(data!.id.toString()))));
                            },
                            child: const Text(
                              'In hóa đơn',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 20, right: 20, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 0, left: 0, bottom: 10, right: 0),
                        child: const Text(
                          "Thông tin chung",
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mã đơn hàng",
                                  style: TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  data.code.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Oswald',
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 0, top: 10, right: 0, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xffEBEBF0),
                                      strokeAlign:
                                      BorderSide.strokeAlignCenter)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Thời gian đặt hàng",
                                  style: TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  data.dateCreated.toString(),
                                  style: const TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, bottom: 10, right: 0),
                        child: const Text(
                          "Chi tiết vận chuyển",
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  child: Image.asset(
                                      "assets/images/icon_home.png",
                                      width: 24),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width - 105,
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 0, right: 0, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Từ cửa hàng",
                                        style: TextStyle(
                                            color: Color(0xff777777),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        data.address.toString(),
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontFamily: 'Oswald',
                                            color: Color(0xff222222),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 0, top: 10, right: 0, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xffEBEBF0),
                                      strokeAlign:
                                      BorderSide.strokeAlignCenter)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  child: Image.asset(
                                      "assets/images/icon_map.png",
                                      width: 24),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width - 105,
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 0, right: 0, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Đến",
                                        style: TextStyle(
                                            color: Color(0xff777777),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        data.address.toString(),
                                        style: const TextStyle(
                                            color: Color(0xff222222),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, bottom: 10, right: 0),
                        child: const Text(
                          "Thông tin sản phẩm",
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListProductOrder(
                              id: int.parse(data!.id.toString()))),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, bottom: 10, right: 0),
                        child: const Text(
                          "Thông tin thanh toán",
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                child: Image.asset(
                                  "assets/images/icon_momo.png",
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 10, bottom: 0, right: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Phương thức thanh toán",
                                    style: TextStyle(
                                        color: Color(0xff777777),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    data.orderPayment!.namevi.toString(),
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 0, bottom: 10, right: 0),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Tổng tạm tính",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      color: Color(0xff525252),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                      .format(data.tempPrice),
                                  style: const TextStyle(
                                      color: Color(0xff525252),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Phí vận chuyển",
                                  style: TextStyle(
                                      color: Color(0xff525252),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                      .format(data.shipPrice),
                                  style: const TextStyle(
                                      color: Color(0xff525252),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Tổng cộng",
                                  style: TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                      .format(data.totalPrice),
                                  style: const TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ListProductOrder extends ConsumerWidget {
  late int id;

  ListProductOrder({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProductOrderDetail =
    ref.watch(OrderRepository.futureProductForDetailProvider('$id'));
    return SingleChildScrollView(
      child: listProductOrderDetail.when(
        error: (err, stack) => Text('Error: $err'),
        data: (List<Product>? data) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          data[index].photo.toString(),
                          fit: BoxFit.cover,
                          width: 55,
                          height: 55,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 0, right: 0, bottom: 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name.toString(),
                                style: const TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Size: ${data[index].size}",
                                style: const TextStyle(
                                    color: Color(0xff6C6C6C),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300),
                              ),
                              Row(
                                children: [
                                  Text(
                                    NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(data[index].salePrice),
                                    style: const TextStyle(
                                        fontFamily: 'Oswald',
                                        color: Color(0xff222222),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(data[index].regularPrice),
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Color(0xff666666),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(" x${data[index].quantity}",
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 0, top: 10, right: 0, bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: const Color(0xffEBEBF0),
                                        strokeAlign:
                                        BorderSide.strokeAlignCenter)),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/models/order.dart';
import 'package:nike/data/repo/order_repository.dart';
import 'package:nike/ui/cart/widgest/cart_info.dart';
import 'package:nike/ui/payment_webview.dart';
import 'package:nike/ui/receipt/payment_receiptscreen.dart';
import 'package:nike/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen(
      {super.key,
      required this.totalPrice,
      required this.payablePrice,
      required this.shippingPrice});
  final int totalPrice;
  final int payablePrice;
  final int shippingPrice;

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController = TextEditingController(
    text: 'سعید',
  );

  final TextEditingController lastNameController =
      TextEditingController(text: 'شاهینی');

  final TextEditingController postalCodeController =
      TextEditingController(text: '7133354852');

  final TextEditingController mobileController =
      TextEditingController(text: "09187139575");

  final TextEditingController addressController =
      TextEditingController(text: 'ایران_تهران_همدان_اهواز_شیراز');

  StreamSubscription? streamSubscription;
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('تحویل گیرنده'),
        ),
        body: BlocProvider<ShippingBloc>(
          create: (context) {
            final bloc = ShippingBloc(orderRepository);
            streamSubscription = bloc.stream.listen((event) {
              if (event is ShippingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(event.appException.messege)));
              } else if (event is ShippingSuccess) {
                if(event.result.bankGatewayUrl.isNotEmpty){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(
                            bankGatewayUrl: event.result.bankGatewayUrl),
                      ));
                } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PaymentReceiptScreen(orderId: event.result.orderId),
                  ));
                }
              }
            });
            return bloc;
          },
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'نام '),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: lastNameController,
                    decoration:
                        const InputDecoration(labelText: ' نام خانوادگی'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: postalCodeController,
                    decoration: const InputDecoration(labelText: ' کدپستی'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(labelText: 'شماره تماس'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'آدرس'),
                  ),
                  const SizedBox(height: 10),
                  CartInfo(
                      payablePrice: widget.payablePrice,
                      totalPrice: widget.totalPrice,
                      shippingPrice: widget.shippingPrice),
                  BlocBuilder<ShippingBloc, ShippingState>(
                    builder: (context, state) {
                      return state is ShippingLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      BlocProvider.of<ShippingBloc>(context)
                                          .add(ShippingCreateOrder(
                                              CreateOrderParams(
                                                  firstNameController.text,
                                                  lastNameController.text,
                                                  postalCodeController.text,
                                                  mobileController.text,
                                                  addressController.text,
                                                  PaymentMethod
                                                      .cashOnDelivery)));
                                    },
                                    child: const Text('پرداخت در محل')),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<ShippingBloc>(context)
                                          .add(ShippingCreateOrder(
                                              CreateOrderParams(
                                                  firstNameController.text,
                                                  lastNameController.text,
                                                  postalCodeController.text,
                                                  mobileController.text,
                                                  addressController.text,
                                                  PaymentMethod
                                                      .online)));
                                    },
                                    child: const Text('پرداخت اینترنتی'))
                              ],
                            );
                    },
                  )
                ],
              ))),
        ));
  }
}

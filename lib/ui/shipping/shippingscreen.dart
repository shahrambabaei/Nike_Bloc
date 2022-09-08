import 'package:flutter/material.dart';
import 'package:nike/ui/cart/widgest/cart_info.dart';
import 'package:nike/ui/receipt/receiptscreen.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen(
      {super.key,
      required this.totalPrice,
      required this.payablePrice,
      required this.shippingPrice});
  final int totalPrice;
  final int payablePrice;
  final int shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'نام و نام خانوادگی'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: ' کدپستی'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'شماره تماس'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'آدرس'),
              ),
              const SizedBox(height: 12),
              CartInfo(
                  payablePrice: payablePrice,
                  totalPrice: totalPrice,
                  shippingPrice: shippingPrice),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const PaymentReceiptScreen()));
                      },
                      child: const Text('پرداخت در محل')),
                  const SizedBox(width: 16),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('پرداخت اینترنتی'))
                ],
              )
            ],
          ))),
    );
  }
}

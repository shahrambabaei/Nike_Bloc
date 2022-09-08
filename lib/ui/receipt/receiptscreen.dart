import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسیدپرداخت'),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: themeData.dividerColor, width: 1)),
          child: Column(children: [
            Text('پرداخت با موفقیت انجام شد',
                style: themeData.textTheme.headline6!
                    .apply(color: LightThemeColors.primaryColor)),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'وضعیت سفارش',
                    style:
                        TextStyle(color: LightThemeColors.secondaryTextColor),
                  ),
                  Text(
                    'پرداخت شده',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    ' مبلغ',
                    style:
                        TextStyle(color: LightThemeColors.secondaryTextColor),
                  ),
                  Text(
                    ' 150000 تومان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ]),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('بازگشت به صفحه اصلی'))
      ]),
    );
  }
}

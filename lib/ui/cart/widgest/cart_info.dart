import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/configs/utils.dart';

class CartInfo extends StatelessWidget {
  const CartInfo(
      {super.key,
      required this.payablePrice,
      required this.totalPrice,
      required this.shippingPrice});
  final int payablePrice;
  final int totalPrice;
  final int shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 10),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text('جزئیات خرید',
                style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: LightThemeColors.surfacedColor,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 5)
                ]),
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                        text: TextSpan(
                            text: totalPrice.saparateByCpmma,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontSize: 15,
                                color: LightThemeColors.secondaryTextColor),
                            children: <TextSpan>[
                          const TextSpan(
                              text:
                                  ' '), //for space between payableprice and 'تومان'
                          TextSpan(
                            text: 'تومان',
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontSize: 12),
                          )
                        ]))
                  ],
                ),
              ),

              const Divider(
                height: 1,
                thickness: .7,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(shippingPrice.withPriceLable)
                  ],
                ),
              ),

              const Divider(
                height: 1,
                thickness: .7,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                        text: TextSpan(
                            text: payablePrice.saparateByCpmma,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          const TextSpan(
                              text:
                                  ' '), //for space between payableprice and 'تومان'
                          TextSpan(
                            text: 'تومان',
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ]))
                  ],
                ),
              )
              //~
              // BuildCartInfo(title: '  مبلغ قابل پرداخت  ', price: payablePrice),
            ]),
          ),
        )
      ],
    );
  }
}

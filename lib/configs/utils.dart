import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => this > 0 ? '$saparateByCpmma تومان' : "رایگان";

  String get saparateByCpmma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

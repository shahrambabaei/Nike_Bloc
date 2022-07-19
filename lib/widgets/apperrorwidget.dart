import 'package:flutter/material.dart';
import 'package:nike/configs/exceptions.dart';

class AppErrorwidget extends StatelessWidget {
  const AppErrorwidget(
      {Key? key, required this.exception, required this.onClick})
      : super(key: key);
  final AppException exception;
  final GestureTapCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(exception.messege),
        ElevatedButton(onPressed: onClick, child: const Text('تلاش دوباره'))
      ]),
    );
  }
}

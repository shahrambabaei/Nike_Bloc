import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {Key? key, required this.message, this.callToAction, required this.image})
      : super(key: key);
  final String message;
  final Widget? callToAction;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
          child: Text(
            message,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        if (callToAction != null) callToAction!,
      ],
    ));
  }
}

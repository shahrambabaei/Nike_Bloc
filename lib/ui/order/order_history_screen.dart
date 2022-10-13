import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/data/repo/order_repository.dart';
import 'package:nike/ui/order/bloc/order_history_bloc.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('سوابق سفارش')),
        body: BlocProvider<OrderHistoryBloc>(
          create: (context) =>
              OrderHistoryBloc(orderRepository)..add(OrderHistoryStarted()),
          child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (context, state) {
              if (state is OrderHistorySuccess) {
                final orders = state.orders;

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context).dividerColor, width: 1),
                      ),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 56,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('شماره سفارش'),
                                Text(order.id.toString())
                              ]),
                        ),
                        const Divider(height: 1),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 56,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مبلغ'),
                                Text(order.payablePrice.withPriceLable)
                              ]),
                        ),
                        const Divider(height: 1),
                        SizedBox(
                          height: 132,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            scrollDirection: Axis.horizontal,
                            itemCount: order.items.length,
                            itemBuilder: (context, index) => Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: ImageLoadingService(
                                  borderRadius: BorderRadius.circular(8),
                                  imageUrl: order.items[index].imageUrl),
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                );
              } else if (state is OrderHistoryError) {
                return Center(
                  child: Text(state.appException.messege),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ));
  }
}

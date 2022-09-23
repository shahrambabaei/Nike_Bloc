import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/data/repo/product_repository.dart';
import 'package:nike/ui/list/bloc/product_list_bloc.dart';
import 'package:nike/widgets/productitem.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.sort});
  final int sort;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType { grid, list }

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;
  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('کفشهای ورزشی'),
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) {
            bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(widget.sort));
            return bloc!;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListsuccess) {
                final products = state.products;
                return Column(
                  children: [
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: LightThemeColors.surfacedColor,
                          border: Border(
                              top: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).dividerColor)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 20),
                          ]),
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 250,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            children: [
                                              Text('انتخاب مرتب سازی',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount:
                                                      state.sortNames.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final selectedSortIndex =
                                                        state.sort;
                                                    return InkWell(
                                                      onTap: () {
                                                        bloc!.add(
                                                          ProductListStarted(
                                                              index),
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 16,
                                                                vertical: 8),
                                                        child: SizedBox(
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Text(state
                                                                      .sortNames[
                                                                  index]),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              if (index ==
                                                                  selectedSortIndex)
                                                                const Icon(
                                                                  CupertinoIcons
                                                                      .check_mark_circled_solid,
                                                                  color: LightThemeColors
                                                                      .primaryColor,
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.sort_down),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('مرتب سازی'),
                                        Text(
                                          ProductSort.names[state.sort],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  viewType = viewType == ViewType.grid
                                      ? ViewType.list
                                      : ViewType.grid;
                                });
                              },
                              icon: const Icon(CupertinoIcons.square_grid_2x2)),
                        )
                      ]),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .65,
                            crossAxisCount: viewType == ViewType.grid ? 2 : 1),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                              product: products[index],
                              borderRadius: BorderRadius.zero);
                        },
                      ),
                    ),
                  ],
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

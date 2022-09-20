import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/product_repository.dart';
import 'package:nike/ui/list/bloc/product_list_bloc.dart';
import 'package:nike/widgets/productitem.dart';


class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.sort});
  final int sort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کفشهای ورزشی'),
      ),
      body: BlocProvider<ProductListBloc>(create: (context) {
        return ProductListBloc(productRepository)..add(ProductListStarted(sort));
      },child: BlocBuilder<ProductListBloc,ProductListState>(builder:(context, state) {
        if (state is ProductListsuccess) {
        final products=state.products;
        return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .65,
          
          crossAxisCount: 2),
        itemCount: products.length,
         itemBuilder:(context, index) {
                    return ProductItem(
                        product: products[index],
                        borderRadius: BorderRadius.zero);
         }, ) ; 
      
        } else {
          return const Center(child: CupertinoActivityIndicator(),);
        }
      },),)
    );
  }
}
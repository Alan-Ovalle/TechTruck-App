import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar
          const SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'CustomScrollView', // Title text for the SliverAppBar
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
          // SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'), // Display list item with index
                );
              },
              childCount: 100, // Number of list items
            ),
          ),
        ],
      ),
    );
  }
}

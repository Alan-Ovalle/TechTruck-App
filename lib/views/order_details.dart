import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar
          SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'CustomScrollView', // Title text for the SliverAppBar
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              background: Image.network(
                'https://static.startuptalky.com/2021/06/GeeksforGeeks-StartupTalky.jpg', // Replace with your image URL
                fit: BoxFit.cover, // Ensure the image covers the entire space
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

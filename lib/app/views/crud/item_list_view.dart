import 'package:crud_mvvm_supabase/app/viewmodels/item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ItemViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: FutureBuilder(
        future: viewModel.loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.items.isEmpty) {
            return Center(child: Text('No items found.'));
          }

          return ListView.builder(
            itemCount: viewModel.items.length,
            itemBuilder: (context, index) {
              final item = viewModel.items[index];
              return ListTile(
                title: Text(item['name']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => viewModel.deleteItem(item['id']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.addItem({'name': 'New Item'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_starter/home/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          context.watch<HomeProvider>().loader
              ? Center(child: CircularProgressIndicator())
              : _placeholderList(context)
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.read<HomeProvider>().apiCall();
        },
        child: Text("Fetch Data"),
      ),
    );
  }

  Widget _placeholderList(BuildContext context) {
  return  context.watch<HomeProvider>().parsedData.isNotEmpty
        ? Expanded(
            child: ListView.builder(
            itemCount: context.watch<HomeProvider>().parsedData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${index +1})  ${context.watch<HomeProvider>().parsedData[index].title ?? ""}"),
              );
            },
          ))
        : Center(
            child: Text("No data Found"),
          );
  }
}

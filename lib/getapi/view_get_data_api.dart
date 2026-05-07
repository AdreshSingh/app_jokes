import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewGetDataApi extends StatefulWidget {
  const ViewGetDataApi({super.key});

  @override
  State<ViewGetDataApi> createState() => _ViewGetDataApiState();
}

class _ViewGetDataApiState extends State<ViewGetDataApi> {
  late Future<dynamic> _jokes;

  Future<dynamic> fetchjokes() async {
    final response = await Dio().get(
      'https://official-joke-api.appspot.com/random_joke',
    );
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    _jokes = fetchjokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.more)),
        centerTitle: true,
        title: const Text('Get Data API'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: FutureBuilder<dynamic>(
          future: _jokes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data.toString()),
                  Joke(snapshot: snapshot),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class Joke extends StatelessWidget {
  final dynamic snapshot;
  const Joke({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Setup: ${snapshot.data['setup']}'),
        Text('Punchline: ${snapshot.data['punchline']}'),
      ],
    );
  }
}

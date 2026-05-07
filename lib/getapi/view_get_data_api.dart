import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewGetDataApi extends StatefulWidget {
  const ViewGetDataApi({super.key});

  @override
  State<ViewGetDataApi> createState() => _ViewGetDataApiState();
}

class _ViewGetDataApiState extends State<ViewGetDataApi> {


  Future<dynamic> fetchjokes()async{
    final response =
    await Dio().get(

      'https://official-joke-api.appspot.com/random_joke'
    );
    return response.data;
  }




  @override
  Future<Widget> build(BuildContext context) async {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.more)),
        centerTitle: true,
        title: const Text('Get Data API'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(padding: const EdgeInsets.all(20),
       
       child: FutureBuilder<String?>(
  future: await fetchjokes(),

  builder: (context, snapshot) {

    if(snapshot.hasData){
      return Text(snapshot.data.toString());
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  },
),

      ),
      
    );
  }
}
import 'package:api_practice/bloc/bloc_main.dart';
import 'package:api_practice/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiPractice _bloc = ApiPractice();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<ApiPractice,InterfaceState>(builder: (context, state) {
            if (state is InitialState) {
              return _loadingList(context);
            } else if (state is PostsDataState) {
              return _dataList(context, state.allData);
            } else {
              return _loadingList(context);
            }
      }),
    ),
          ],
        ));
  }

  Widget _dataList(BuildContext context, List data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final comment = data[index];
        return Row(
          children: [
          // Text("${post["userId"]}\n"),
            Text(comment["email"].toString()),
          ],
        );
      }),
    );
  }
  // Widget _dataList(BuildContext context,List data){
  //   return Expanded(child:
  //   );
  // }

  Widget _loadingList(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorMessage(BuildContext context, String msg) {
    return Center(
      child: Text(msg),
    );
  }
}

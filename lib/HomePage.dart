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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:50.0,left: 10),
                  child: ElevatedButton(onPressed: (){
                    _bloc.add(ButtonEvent());
                  }, child:const Text(
                    "Comment",style: TextStyle(fontSize: 20),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:50.0,left: 10),
                  child: ElevatedButton(
                      onPressed: (){
                      _bloc.add(PostCommentEvent());
                      }, child: const Text(
                    "PostComment",style: TextStyle(fontSize:20),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:50.0,left: 10),
                  child: ElevatedButton(
                      onPressed: (){
                        _bloc.add(GetDataEvent());
                      }, child: const Text(
                    "Post",style: TextStyle(fontSize:20),
                  )),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:50.0,left: 10),
                  child: ElevatedButton(
                      onPressed: (){
                        _bloc.add(PatchEvent());
                      }, child: const Text(
                    "Patch",style: TextStyle(fontSize:20),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:50.0,left: 10),
                  child: ElevatedButton(
                      onPressed: (){
                        _bloc.add(DeleteEvent());
                      }, child: const Text(
                    "Delete",style: TextStyle(fontSize:20),
                  )),
                ),
              ],
            ),
            BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<ApiPractice,InterfaceState>(builder: (context, state) {
            if (state is InitialState) {
              return _loadingList(context);
             } else if (state is PostsDataState) {
               return _dataList(context, state.allData);
             }
            else if(state is ButtonState){
              return _commentList(context,state.allComments);
            }
            else {
              return _loadingList(context);
            }
      }),
        ),
          ],
        )
    );
  }

  Widget _dataList(BuildContext context, List data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final post = data[index];
        return Row(
          children: [
           Text("${post["id"]}\n"),
           // Text("${post["title"]}"),
          ],
        );
      }),
    );
  }
  Widget _commentList(BuildContext context, List comment) {
    return Expanded(
      child: ListView.builder(
          itemCount: comment.length,
          itemBuilder: (context, index) {
            final comments = comment[index];
            return Row(
              children: [
                Text("postId: ${comments["postId"]}\n"),
                Text("id: ${comments["id"]}\n"),
                Text(comments["email"].toString()),
              ],
            );
          }),
    );
  }

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

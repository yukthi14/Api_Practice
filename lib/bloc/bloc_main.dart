import 'dart:convert';
import 'package:api_practice/bloc/bloc_event.dart';
import 'package:api_practice/bloc/bloc_state.dart';
import 'package:api_practice/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiPractice extends Bloc<InterfaceEvent, InterfaceState> {
  ApiPractice() :super(InitialState()) {
    final List show = [];
    on<GetDataEvent>((event, emit) async {
      try {
        Response response = await http.get(Uri.http(Strings.uri, Strings.path));
        //print(response.body);
        var data = json.decode(response.body) as List;
        if (response.statusCode == 200) {
          // for(Map i in data) {
          //   show.add(i);
          // }
          print(data);
        }

        emit(PostsDataState(allData: data));
      }
      catch (e) {
        emit(ErrorMessage(msg: Strings.errorMessage));
      }
    });
    on<ButtonEvent>((event, emit) async {
      try {
        Response response = await http.get(
            Uri.http(Strings.uri, Strings.comment));
        var comment = json.decode(response.body) as List;
        if (response.statusCode == 200) {
          print(comment);
        }
        emit(ButtonState(allComments: comment));
      }
      catch (e) {
        emit(ErrorMessage(msg: Strings.errorMessage));
      }
    });
    on<PostCommentEvent>((event, emit) async {
      try {
        Response response = await http.post(Uri.http(Strings.uri, Strings.path),
            body: {
              "userId": "1",
              "id": "5",
              "title": "SETU IS SEXY",
              "body": "sexy sexy sexy setu"
            });
        // print(response.body);
        // print(response.statusCode);
      }
      catch (e) {
        print("Data cannot be inserted");
      }
    });
    on<PatchEvent>((event, emit) async {
      try {
        await http.patch(Uri.http("jsonplaceholder.typicode.com/posts/1"),
          body: json.encode({
            "userId": 1,
            "id": 1,
            "title": "sunt reprehenderit",
            "body": "  eveniet architecto"
          }),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        ).then((value) {
          print(value.statusCode);
          print(value.body);
        });
        //  if(response.statusCode==200){
        //    Fluttertoast.showToast(msg:"patch success" );
        //  emit(ToastMsgState(toastMsg: "patch success"));
        //  }
        //  else{
        //    Fluttertoast.showToast(msg:"patch not success" );
        //    emit(ToastMsgState(toastMsg: "patch not success"));
        //  }
        // print(response.body);
        // print(response.statusCode);
        emit(ToastMsgState(toastMsg: "patch success"));
      }
      catch (e) {
        emit(ToastMsgState(toastMsg: "Exception thrown"));
      }
    });
    on<DeleteEvent>((event, emit) async {
      try {
        Response response = await http.patch(
          Uri.parse("jsonplaceholder.typicode.com/posts/1"),

        );
        if (response.statusCode == 200) {
          emit(ToastMsgState(toastMsg: "deleted success"));
        }
        else {
          emit(ToastMsgState(toastMsg: "delete not successful"));
        }
        print(response.body);
        print(response.statusCode);
      }
      catch (e) {
        emit(ToastMsgState(toastMsg: "Exception thrown"));
      }
    });
  }
}
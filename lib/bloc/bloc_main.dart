import 'dart:convert';
import 'package:api_practice/bloc/bloc_event.dart';
import 'package:api_practice/bloc/bloc_state.dart';
import 'package:api_practice/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiPractice extends Bloc<InterfaceEvent,InterfaceState>{
  ApiPractice():super(InitialState()){
    final List show=[];
    on<GetDataEvent>((event,emit)async{

    try{
      Response response = await http.get(Uri.http(Strings.uri,Strings.comment));
      //print(response.body);
      var data = json.decode(response.body)as List;
      if(response.statusCode==200){
      // for(Map i in data) {
      //   show.add(i);
      // }
      print(data);
      }

      emit(PostsDataState(allData:data));
    }
    catch(e){
      emit(ErrorMessage(msg: Strings.errorMessage));
    }
    });
    
  }
}
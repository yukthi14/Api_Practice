abstract class InterfaceState{

}
class InitialState extends InterfaceState{
  InitialState();
}
class PostsDataState extends InterfaceState{
  List allData;
   PostsDataState({required this.allData});
}
class ErrorMessage extends InterfaceState{
  String msg;
  ErrorMessage({required this.msg});
}

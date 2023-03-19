abstract class InterfaceState{

}
class InitialState extends InterfaceState{
  InitialState();
}
class PostsDataState extends InterfaceState{
  List allData;
   PostsDataState({required this.allData});
}
class ButtonState extends InterfaceState{
  List allComments;
  ButtonState({required this.allComments});
}
class PostCommentState extends InterfaceState{
 PostCommentState();
}
class ErrorMessage extends InterfaceState{
  String msg;
  ErrorMessage({required this.msg});
}
class PatchState extends InterfaceState{
  PatchState();
}
class DeleteState extends InterfaceState{
  DeleteState();
}
class ToastMsgState extends InterfaceState{
  String toastMsg;
  ToastMsgState({required this.toastMsg});
}

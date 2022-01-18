import 'package:bloc/bloc.dart';


class InputTextCubit extends Cubit<InputTextState> {
  InputTextCubit() : super(InputTextState(inputText: ""));

  void inputtext() => emit(InputTextState(inputText: ""));
}

class InputTextState {
  String inputText;

  InputTextState({
    required this.inputText,
  });
}
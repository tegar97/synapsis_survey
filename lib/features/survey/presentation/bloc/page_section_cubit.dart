import 'package:flutter_bloc/flutter_bloc.dart';

class PageSectionCubit extends Cubit<int> {
  PageSectionCubit() : super(0);


  changePage(int number){
    emit(number);
  }
}

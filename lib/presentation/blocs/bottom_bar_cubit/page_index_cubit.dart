import 'package:flutter_bloc/flutter_bloc.dart';

class PageIndexCubit extends Cubit<int> {
  PageIndexCubit() : super(0);

  void onItemTapped(int index) => emit(index);

  void getToProjects() => emit(0);

  void getToAccounts() => emit(1);
}

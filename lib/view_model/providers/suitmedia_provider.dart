import 'package:flutter/material.dart';
import 'package:suitmedia_test/model/service/remote_datasources.dart';
import 'package:suitmedia_test/view_model/models/user.dart';
import 'package:suitmedia_test/utils/states_enum.dart';

class SuitmediaProvider with ChangeNotifier {
  RequestState state = RequestState.noData;
  RemoteDataSource remoteDataSource = RemoteDataSourceImpl();
  String username = "Selected User Name";
  String name = '';
  String dialog = "isPalindrome";
  bool ans = true;
  List<User> data = [];
  int page = 1;
  int total = 0;

  getUser() async {
    try {
      if (page == 1) {
        state = RequestState.loading;
        notifyListeners();
      }
      final result = await remoteDataSource.getListUser(page);
      data += result.data;

      page++;
      total = result.total;
      state = RequestState.hasData;
      notifyListeners();
    } catch (e) {
      state = RequestState.noData;
      notifyListeners();
    }
  }

  changeName(String name) {
    this.name = name;
    if (name == '') {
      this.name = "Anonymous";
    }
  }

  selectUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  onCheck(String palindrome) {
    ans = true;
    int last = palindrome.length - 1, idx = 0;
    while (idx < last) {
      if (palindrome[idx] == ' ') idx++;
      if (palindrome[last] == ' ') last--;
      if (palindrome[idx] != palindrome[last]) {
        ans = false;
        break;
      }
      idx++;
      last--;
    }
    (ans) ? dialog = "isPalindrome" : dialog = "not palindrome";
  }
}

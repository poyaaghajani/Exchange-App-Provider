class UserModel {
  UserModel({
    Record? record,
    String? token,
  }) {
    _record = record;
    _token = token;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _record = json['record'] != null ? Record.fromJson(json['record']) : null;
    _token = json['token'];
  }

  Record? _record;
  String? _token;

  Record? get record => _record;
  String? get token => _token;
}

class Record {
  Record({
    String? username,
  }) {
    _username = username;
  }

  Record.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
  }

  String? _username;

  String? get username => _username;
}

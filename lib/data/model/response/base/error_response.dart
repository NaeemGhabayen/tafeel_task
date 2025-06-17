class ErrorResponse {
  List<Errors>? _errors;

  List<Errors>? get errors => _errors;

  ErrorResponse({List<Errors>? errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (json['error'] != null) {
      _errors = [];
      json[""].forEach((v) {
        _errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map["error"] = _errors!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  String? _code;
  String? _detail;

  String? get code => _code;
  String? get detail => _detail;

  Errors({String? code, String? detail}) {
    _code = code;
    _detail = detail;
  }

  Errors.fromJson(dynamic json) {
    _code = json["code"];
    _detail = json["detail"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["detail"] = _detail;
    return map;
  }
}

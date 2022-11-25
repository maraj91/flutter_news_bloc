
/// This model class get created using
/// https://dart-quicktype.netlify.app/
///
class CountryListMain {
  final List<Data>? data;

  CountryListMain({this.data});

  factory CountryListMain.fromJson(Map<String, dynamic> json) {
    return CountryListMain(
        data: json['data'] == null ? [] : List<Data>.from(json['data']!.map((x) => Data.fromJson(x)))
    );
  }
}

class Data {
  final String name;
  final String flag;
  final String code;

  Data({required this.name, required this.flag, required this.code});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        name: json['name'] ?? "",
        flag: json['flag'] ?? "",
        code: json['code'] ?? ""
    );
  }
}
/// q : "Tragedy is a tool for the living to gain wisdom, not a guide by which to live."
/// a : "Robert F. Kennedy"
/// h : "<blockquote>&ldquo;Tragedy is a tool for the living to gain wisdom, not a guide by which to live.&rdquo; &mdash; <footer>Robert F. Kennedy</footer></blockquote>"
library;

class QuoteModel {
  QuoteModel({
    String? q,
    String? a,
    String? h,}){
    _q = q;
    _a = a;
    _h = h;
  }

  QuoteModel.fromJson(dynamic json) {
    _q = json['q'];
    _a = json['a'];
    _h = json['h'];
  }
  String? _q;
  String? _a;
  String? _h;
  QuoteModel copyWith({  String? q,
    String? a,
    String? h,
  }) => QuoteModel(  q: q ?? _q,
    a: a ?? _a,
    h: h ?? _h,
  );
  String? get q => _q;
  String? get a => _a;
  String? get h => _h;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['q'] = _q;
    map['a'] = _a;
    map['h'] = _h;
    return map;
  }

}
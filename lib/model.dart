class ResponseUrl {
  String resultUrl;

  ResponseUrl({this.resultUrl});

  ResponseUrl.fromJson(Map<String, dynamic> json) {
    resultUrl = json['result_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result_url'] = this.resultUrl;
    return data;
  }
}

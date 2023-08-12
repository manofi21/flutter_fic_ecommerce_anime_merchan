class OrderResultModel {
    final String token;
    final String redirectUrl;

    OrderResultModel({
        required this.token,
        required this.redirectUrl,
    });

    static OrderResultModel fromJson(Map<String, dynamic> json) => OrderResultModel(
        token: json["token"],
        redirectUrl: json["redirect_url"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "redirect_url": redirectUrl,
    };
}

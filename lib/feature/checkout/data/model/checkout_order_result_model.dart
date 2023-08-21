class CheckoutOrderResultModel {
    final String token;
    final String redirectUrl;

    CheckoutOrderResultModel({
        required this.token,
        required this.redirectUrl,
    });

    static CheckoutOrderResultModel fromJson(Map<String, dynamic> json) => CheckoutOrderResultModel(
        token: json["token"],
        redirectUrl: json["redirect_url"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "redirect_url": redirectUrl,
    };
}

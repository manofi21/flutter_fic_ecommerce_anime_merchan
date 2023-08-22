extension OrderStatusToEntity on String {
  String get toOrderStatusEntity {
    switch (this) {
      case 'waitingPayment':
        return "Menunggu Pembayaran";
      case 'purchased':
        return "Terbayarkan";
      case 'onDelivery':
        return "Dalam Pengiriman";
      case 'delivered':
        return "Terkirim";
      case 'cancel':
        return "Dibatalkan";
      default:
        return "";
    }
  }
}

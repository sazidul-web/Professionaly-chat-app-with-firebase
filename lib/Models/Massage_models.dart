class MassageModels {
  final String? message;
  final String? sender;
  final String? reciver;
  final String? datetime;
  final DateTime? timestamp;
  final bool? isSeenByReceiver;
  final bool? isImage;

  MassageModels({
    this.message,
    this.sender,
    this.reciver,
    this.datetime,
    this.timestamp,
    this.isSeenByReceiver,
    this.isImage,
  });

  // that will convart document model to message model
  factory MassageModels.formMap(Map<String, dynamic> map) {
    return MassageModels(
      message: map["message"],
      sender: map["senderId"],
      reciver: map["RecivedId"],
      timestamp: map["timestramp"],
      isSeenByReceiver: map["isSeenByReciver"],
      isImage: map["isImages"],
    );
  }
}

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
}

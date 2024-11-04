class RepairRequestModel {
  final String id;
  final String userId;
  final String productId;
  final String empresaId;
  final String sucursalId;
  final String description;
  final String status;
  final DateTime requestDate;

  RepairRequestModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.empresaId,
    required this.sucursalId,
    required this.description,
    required this.status,
    required this.requestDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'empresaId': empresaId,
      'sucursalId': sucursalId,
      'description': description,
      'status': status,
      'requestDate': requestDate.toIso8601String(),
    };
  }

  factory RepairRequestModel.fromMap(Map<String, dynamic> map, String id) {
    return RepairRequestModel(
      id: id,
      userId: map['userId'],
      productId: map['productId'],
      empresaId: map['empresaId'],
      sucursalId: map['sucursalId'],
      description: map['description'],
      status: map['status'],
      requestDate: DateTime.parse(map['requestDate']),
    );
  }
}
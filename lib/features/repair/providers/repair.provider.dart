import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glib_practicas/features/repair/models/repair_request.model.dart';

class RepairProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<RepairRequestModel> _requests = [];

  List<RepairRequestModel> get requests => _requests;

  Future<void> createRepairRequest(RepairRequestModel request) async {
    await _firestore
        .collection('repair_requests')
        .doc(request.id)
        .set(request.toMap());
    _requests.add(request);
    notifyListeners();
  }

  Future<void> getUserRepairRequests(String userId) async {
    var querySnapshot = await _firestore
        .collection('repair_requests')
        .where('userId', isEqualTo: userId)
        .get();

    _requests = querySnapshot.docs
        .map((doc) => RepairRequestModel.fromMap(doc.data(), doc.id))
        .toList();

    notifyListeners();
  }

  Future<void> updateRepairRequest(RepairRequestModel updatedRequest) async {
    await _firestore
        .collection('repair_requests')
        .doc(updatedRequest.id)
        .update(updatedRequest.toMap());
    _requests[_requests.indexWhere((req) => req.id == updatedRequest.id)] =
        updatedRequest;
    notifyListeners();
  }

  Future<void> deleteRepairRequest(String requestId) async {
    await _firestore.collection('repair_requests').doc(requestId).delete();
    _requests.removeWhere((request) => request.id == requestId);
    notifyListeners();
  }
}

import 'package:sangvie/core/services/data_service.dart';
import 'package:sangvie/data/models/blood_request_model.dart';

class BloodRequestRepository {
  Future<List<BloodRequest>> getUrgentRequests() async {
    // Simule un appel API via DataService
    await Future.delayed(const Duration(milliseconds: 300));
    return DataService.demandesUrgentes
        .map((m) => BloodRequest.fromMock(m))
        .toList();
  }

  Future<List<BloodRequest>> getRecentRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DataService.recentRequests
        .map((m) => BloodRequest.fromMock(m))
        .toList();
  }
}

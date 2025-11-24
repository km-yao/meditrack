
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/services/med_service.dart';

final medServiceProvider = Provider<MedService>((ref) => MedService());

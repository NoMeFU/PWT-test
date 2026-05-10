import 'package:lawbug829/features/subscription/subcription_service/subscription_provider.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

var providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: ((context) => AuthProvider()),
  ),
  ChangeNotifierProvider<PurchaseProvider>(
    create: ((context) => PurchaseProvider()),
  ),
];

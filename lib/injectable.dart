import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/injectable.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<GetIt> configure() async => getIt.init();

// ignore_for_file: avoid_classes_with_only_static_members
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'tankerKoenigApiKey', obfuscate: true)
  static String? tankerKoenigApiKey = _Env.tankerKoenigApiKey;
}

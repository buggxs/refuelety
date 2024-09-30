// ignore_for_file: avoid_classes_with_only_static_members
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'TANKERKEONIG_API_KEY', obfuscate: true)
  static final String tankerKoenigApiKey = _Env.tankerKoenigApiKey;
  
}
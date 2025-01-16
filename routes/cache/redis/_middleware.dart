import 'package:dart_frog/dart_frog.dart';

String? greeting;
Handler middleware(Handler handler) {
  return handler
      .use(provider<String>((context) => greeting ??= 'hello my name is kim!'));
}

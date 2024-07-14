import 'package:gemini_app/app/bindings/app_binding.dart';
import 'package:gemini_app/app/views/ui/chatscreen.dart';
import 'package:gemini_app/app/views/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.CHAT,
        page: () => ChatScreen(),
        binding: ChatBinding()),
  ];
}
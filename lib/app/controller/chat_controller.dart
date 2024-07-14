import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gemini_app/app/api/gemini_api.dart';

class ChatController extends GetxController {
  final GeminiService _geminiService = GeminiService();
  var messages = <String>[].obs;
  var isLoading = false.obs;
  final TextEditingController textController = TextEditingController();

  void sendMessage(String message) async {
    messages.add(message);
    isLoading.value = true;

    try {
      String response = await _geminiService.generateResponse(message);
      messages.add(response);
    } catch (e) {
      messages.add('Error: $e');
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  SpeechToText speechToText = SpeechToText();
  var text = "hold the button and start speaking";
  var isListening = false;
  var answer = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 60,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.pink,
        repeat: true, //
        repeatPauseDuration: const Duration(milliseconds: 100), //
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
                if (speechToText.isListening) {}
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: const CircleAvatar(
            radius: 30,
            child: Icon(Icons.mic),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('B R A H M A'),
        centerTitle: true,
      ),
      body: Align(
        alignment: const AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // black container for chatgpt
              Container(
                height: 600,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Column(),
                ),
              ),
              const Text(
                "Developed by Utkarsh Shrivastava",
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ChatBubble() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.black87,
          child: Icon(Icons.person, color: Colors.white,),
        ),
        const SizedBox(width: 12,),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: const Text(
            "Hey, How are you",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

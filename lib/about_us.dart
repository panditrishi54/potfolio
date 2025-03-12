import 'package:flutter/material.dart';
import 'dart:math';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Skill Diagram")),
      body: const Center(child: SkillDiagram()),
    );
  }
}

class SkillDiagram extends StatelessWidget {
  const SkillDiagram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: SkillDiagramPainter(),
    );
  }
}

class SkillDiagramPainter extends CustomPainter {
  final List<SkillCircle> skills = [
    SkillCircle("Flutter", const Offset(100, 100), Colors.blue),
    SkillCircle("Firebase", const Offset(170, 100), Colors.orange),
    SkillCircle("Python", const Offset(130, 160), Colors.green),
    SkillCircle("Java", const Offset(200, 160), Colors.purple),
    SkillCircle("C", const Offset(80, 200), Colors.red),
    SkillCircle("C", const Offset(80, 200), Colors.grey),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var skill in skills) {
      paint.color = skill.color.withOpacity(0.6);
      // Increase the radius from 50 to 70.
      canvas.drawCircle(skill.position, 70, paint);

      // Draw text in the center of the circle.
      final textSpan = TextSpan(
        text: skill.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final textOffset =
          skill.position - Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SkillCircle {
  final String name;
  final Offset position;
  final Color color;

  SkillCircle(this.name, this.position, this.color);
}

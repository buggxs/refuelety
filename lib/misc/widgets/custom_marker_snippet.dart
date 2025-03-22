import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';

class CustomMarkerGenerator {
  Future<BitmapDescriptor> createCustomMarker(
    FuelStation station,
  ) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Fixe Größe für den Marker
    const double width = 160;
    const double height = 80;

    // Hintergrundform (Sprechblase)
    final RRect cardRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(
        height / 2,
      ), // Halb so hoch wie das Element = komplett rund
    );
    final Paint backgroundPaint = Paint()..color = Colors.grey[200]!;
    canvas.drawRRect(cardRect, backgroundPaint);

    // Preisbereich (roter Kreis mit Zapfsäule)
    const double circleSize = 50;
    final Paint circlePaint = Paint()
      ..color = (station.isOpen ?? true) ? Colors.green : Colors.redAccent;
    canvas.drawCircle(
      const Offset(circleSize / 2 + 10, height / 2),
      circleSize / 2,
      circlePaint,
    );

    // Zapfsäulen-Icon
    final TextPainter iconText = TextPainter(
      text: const TextSpan(
        text: '⛽',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    // Berechne die Mitte des Kreises
    final double iconOffsetX = (circleSize / 2 + 10) - (iconText.width / 2);
    final double iconOffsetY = (height / 2) - (iconText.height / 2);

    // Zapfsäulen-Icon zeichnen
    iconText.paint(canvas, Offset(iconOffsetX, iconOffsetY));

    // Preistext
    final TextPainter priceText = TextPainter(
      text: TextSpan(
        text: '${station.e5?.toStringAsFixed(2)} €',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - circleSize - 20);
    // Vertikale Position berechnen, sodass der Preistext zentriert wird
    final double priceOffsetY = (height / 2) - (priceText.height / 2);

    // Preistext neu ausrichten
    priceText.paint(canvas, Offset(circleSize + 20, priceOffsetY));

    // Zeiger (kleines Dreieck unten)
    const double triangleHeight = 12;
    final Path pointerPath = Path()
      ..moveTo(width / 2 - 10, height) // Linke Ecke des Dreiecks
      ..lineTo(width / 2, height + triangleHeight) // Spitze nach unten
      ..lineTo(width / 2 + 10, height) // Rechte Ecke des Dreiecks
      ..close();

    final Paint pointerPaint = Paint()..color = Colors.grey[200]!;
    canvas.drawPath(pointerPath, pointerPaint);

    // Konvertiere Canvas in ein Bild
    final ui.Picture picture = recorder.endRecording();
    final ui.Image img =
        await picture.toImage(width.toInt(), (height + 10).toInt());
    final ByteData? pngBytes =
        await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(pngBytes!.buffer.asUint8List());
  }
}

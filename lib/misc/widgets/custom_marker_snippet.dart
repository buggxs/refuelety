import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:refuelety/api/api.dart';

class CustomMarkerGenerator {
  Future<BitmapDescriptor> createCustomMarker(FuelStation station) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Größere Dimensionen für den Tooltip
    const double width = 350;
    const double height = 250;

    // Zeichne den Tooltip-Hintergrund
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final Path tooltipPath = Path()
      ..moveTo(width / 2 - 50, height - 30) // Start oben links vom Dreieck
      ..lineTo(width / 2, height) // Spitze des Dreiecks
      ..lineTo(width / 2 + 50, height - 30) // Ende oben rechts vom Dreieck
      ..lineTo(width - 20, height - 30) // Obere rechte Ecke
      ..quadraticBezierTo(
          width, height - 30, width, height - 40) // Gerundete Ecke
      ..lineTo(width, 20) // Rechte Seite
      ..quadraticBezierTo(width, 0, width - 20, 0) // Gerundete Ecke
      ..lineTo(20, 0) // Obere Seite
      ..quadraticBezierTo(0, 0, 0, 20) // Gerundete Ecke
      ..lineTo(0, height - 40) // Linke Seite
      ..quadraticBezierTo(0, height - 30, 20, height - 30) // Gerundete Ecke
      ..close();

    // Zeichne Schatten
    canvas
      ..drawPath(tooltipPath, shadowPaint)

      // Zeichne Hauptform
      ..drawPath(tooltipPath, paint);

    // Zeichne Rahmen mit dynamischer Farbe basierend auf isOpen
    final Paint borderPaint = Paint()
      ..color = station.isOpen == true ? Colors.green : Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawPath(tooltipPath, borderPaint);

    // Zeichne den Markennamen oben
    final TextPainter brandText = TextPainter(
      text: TextSpan(
        text: station.brand ?? 'Unbekannt',
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 40);
    brandText.paint(
      canvas,
      Offset(
        (width - brandText.width) / 2,
        20,
      ),
    );

    // Zeichne den Diesel-Preis
    if (station.diesel != null) {
      final TextPainter priceText = TextPainter(
        text: TextSpan(
          children: <TextSpan>[
            const TextSpan(
              text: 'Diesel\n',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 28,
                height: 1.2,
              ),
            ),
            TextSpan(
              text: '${station.diesel?.toStringAsFixed(2)} €',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 42,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(
          maxWidth: width - 40,
          minWidth: width - 40,
        )
        ..paint(
          canvas,
          const Offset(20, 75),
        );
    }

    // Optional: Zeichne den Status-Text
    final TextPainter statusText = TextPainter(
      text: TextSpan(
        text: station.isOpen == true ? 'Geöffnet' : 'Geschlossen',
        style: TextStyle(
          color: station.isOpen == true ? Colors.green : Colors.red,
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    statusText.paint(
      canvas,
      Offset(
        (width - statusText.width) / 2,
        height - 70,
      ),
    );

    // Konvertiere das Canvas in ein Bild
    final Picture picture = recorder.endRecording();
    final ui.Image img = await picture.toImage(width.toInt(), height.toInt());
    final ByteData? pngBytes = await img.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.fromBytes(pngBytes!.buffer.asUint8List());
  }
}

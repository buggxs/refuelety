import 'package:flutter/material.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/fuel_station/widgets/station_info_window.dart';

class AnimatedStationInfoWindow extends StatefulWidget {
  const AnimatedStationInfoWindow({
    super.key,
    required this.station,
    required this.isVisible,
    this.onClose,
  });

  final FuelStation station;
  final VoidCallback? onClose;
  final bool isVisible;

  @override
  State<AnimatedStationInfoWindow> createState() =>
      _AnimatedStationInfoWindowState();
}

class _AnimatedStationInfoWindowState extends State<AnimatedStationInfoWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Startet von unten außerhalb des Bildschirms
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedStationInfoWindow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: StationInfoWindow(
                station: widget.station,
                onClose: () {
                  // Erst Animation ausführen, dann schließen
                  _controller.reverse().then((_) {
                    if (widget.onClose != null) {
                      widget.onClose!();
                    }
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

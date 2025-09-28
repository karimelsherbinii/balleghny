import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

import '../utils/app_colors.dart';

class AnimatedAppBar extends StatefulWidget {
  final String animatedText;
  final bool haveLeading;
  final Color? leadingColor;
  final Function()? onLeadingTap;
  final List<Widget>? actions;
  const AnimatedAppBar(
      {super.key,
      required this.animatedText,
      required this.haveLeading,
      this.leadingColor,
      this.onLeadingTap,
      this.actions});
  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final bool _paused = false;
  late double _textWidth;
  void _calculateTextWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.animatedText,
        style: const TextStyle(fontSize: 20),
      ),
      textDirection: TextDirection.rtl,
    )..layout();
    _textWidth = textPainter.width;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
    _controller.forward();
    _calculateTextWidth();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(
                  1 - _controller.value * (_textWidth + context.width),
                  0,
                ),
                child: FittedBox(
                  child: Text(
                    widget.animatedText,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              fontSize: context.width * 0.05,
                            ),
                  ),
                ),
              ),
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(
                  1 - _controller.value * (context.width - _textWidth),
                  0,
                ),
                child: FittedBox(
                  child: Text(
                    widget.animatedText,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              fontSize: context.width * 0.05,
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: widget.haveLeading && Platform.isIOS
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: widget.leadingColor ?? AppColors.primaryColor),
              onPressed: widget.onLeadingTap ?? () => Navigator.pop(context),
            )
          : widget.haveLeading && Platform.isAndroid
              ? IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: widget.leadingColor ?? AppColors.primaryColor),
                  onPressed:
                      widget.onLeadingTap ?? () => Navigator.pop(context),
                )
              : null,
      actions: widget.actions,
    );
  }
}

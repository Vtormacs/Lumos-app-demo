import 'package:flutter/material.dart';

class ScrollToTopWrapper extends StatefulWidget {
  final Widget Function(ScrollController controller) builder;
  final double showOffset; 

  const ScrollToTopWrapper({
    super.key,
    required this.builder,
    this.showOffset = 300,
  });

  @override
  State<ScrollToTopWrapper> createState() => _ScrollToTopWrapperState();
}

class _ScrollToTopWrapperState extends State<ScrollToTopWrapper> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= widget.showOffset && !_showButton) {
      setState(() => _showButton = true);
    } else if (_scrollController.offset < widget.showOffset && _showButton) {
      setState(() => _showButton = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.builder(_scrollController),
      
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _showButton ? 1.0 : 0.0,
        child: _showButton
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: const Color(0xFF1E3460), 
                mini: true, 
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              )
            : null, 
      ),
    );
  }
}
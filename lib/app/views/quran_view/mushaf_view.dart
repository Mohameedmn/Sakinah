import 'package:flutter/material.dart';

class MushafView extends StatefulWidget {
  final int startPage; // First page of the surah
  final int endPage;   // Last page of the surah

  const MushafView({
    super.key,
    required this.startPage,
    required this.endPage,
  });

  @override
  State<MushafView> createState() => _MushafViewState();
}

class _MushafViewState extends State<MushafView> {
  late final PageController _controller;
  late int currentPage;

  @override
  void initState() {
    currentPage = widget.startPage;
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = widget.endPage - widget.startPage + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Page $currentPage'),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _controller,
        reverse: true,
        itemCount: totalPages,
        onPageChanged: (index) {
          setState(() {
            currentPage = widget.startPage + index;
          });
        },
        itemBuilder: (context, index) {
          final pageNum = widget.startPage + index;
          final img = pageNum.toString().padLeft(3, '0');
          return InteractiveViewer(
            panEnabled: true,
            minScale: 0.9,
            maxScale: 3.0,
            child: Center(
              child: Image.asset(
                'assets/quran_pages/$img.png',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:db/bean/ChapterResponse.dart';

class FloatingMenu extends StatefulWidget {
  final List<Chapter> chapters;
  final void Function(int index) handleButtonClick;
  final int currentPageIndex;

  const FloatingMenu({
    required this.chapters,
    required this.handleButtonClick,
    required this.currentPageIndex,
    Key? key,
  }) : super(key: key);

  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isMenuOpen = false;
  int _selectedIndex = 0;
  List<String> menuItems = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Initialize menu items only if titles are not empty
    if (widget.chapters.isNotEmpty) {
      menuItems = widget.chapters.map((chapter) => chapter.name).toList();
    } else {
      menuItems = [];
    }
  }

  @override
  void didUpdateWidget(covariant FloatingMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local _selectedIndex when currentPageIndex changes
    if (widget.currentPageIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.currentPageIndex;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _controller.forward();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToSelectedItem();
        });
      } else {
        _controller.reverse();
      }
    });
  }

  void selectMenuItem(int index) {
    widget.handleButtonClick(index); // Notify parent of the selection
    setState(() {
      _selectedIndex = index; // Update local selected index
      toggleMenu();
    });
  }

  void scrollToSelectedItem() {
    if (_scrollController.hasClients) {
      double itemExtent = 100.0; // Adjust item extent according to your UI
      double offset = _selectedIndex * itemExtent;
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedMenuItemName = menuItems.isNotEmpty ? menuItems[_selectedIndex] : '';

    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _isMenuOpen ? MediaQuery.of(context).size.width : 0,
            height: 40,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return buildMenuItem(index, menuItems[index]);
              },
            ),
          ),
          const SizedBox(height: 8), // Spacer between menu and FAB
          FloatingActionButton(
            backgroundColor: Colors.blue[900],
            onPressed: toggleMenu,
            child: Text(
              selectedMenuItemName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(int index, String text) {
    bool isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => selectMenuItem(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[900] : Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

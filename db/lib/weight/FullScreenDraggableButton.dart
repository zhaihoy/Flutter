import 'dart:math';
import 'package:flutter/material.dart';


class RadialMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DragExpandMenu();
  }
}

class DragExpandMenu extends StatefulWidget {
  @override
  _DragExpandMenuState createState() => _DragExpandMenuState();
}

class _DragExpandMenuState extends State<DragExpandMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    isMenuOpen
        ? _animationController.reverse()
        : _animationController.forward();
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Expand Menu'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            _toggleMenu();
          }
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: GestureDetector(
                onTap: _toggleMenu,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: Stack(
                    children: [
                      for (int i = 0; i < 5; i++)
                        _buildMenuItem(
                          index: i,
                          totalItems: 5,
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required int index, required int totalItems}) {
    double angle = index * 2 * pi / totalItems;
    double menuRadius = 120.0;
    double x = menuRadius * cos(angle);
    double y = menuRadius * sin(angle);

    return Positioned(
      bottom: 16.0 + y,
      right: 16.0 + x,
      child: GestureDetector(
        onTap: () {
          // Handle menu item click
          print('Clicked on menu item $index');
        },
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

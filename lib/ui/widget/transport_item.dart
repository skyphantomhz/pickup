import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/data/transport_type.dart';

class TransportItem extends StatefulWidget {
  final TransportType transport;
  final IconData icon;
  final ValueChanged<TransportType> onSelected;

  TransportItem({this.transport, this.icon, this.onSelected});

  @override
  _TransportItemState createState() => _TransportItemState();
}

class _TransportItemState extends State<TransportItem> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onSelected(widget.transport);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: _highlight ? Colors.green : Colors.white,
            boxShadow: _highlight ? [BoxShadow(blurRadius: 5)] : [],
            shape: BoxShape.circle),
        child: Icon(
          widget.icon,
          size: 50,
        ),
      ),
      onTap: _handleTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
    );
  }
}

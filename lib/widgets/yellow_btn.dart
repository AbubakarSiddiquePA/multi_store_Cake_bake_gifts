import 'package:flutter/material.dart';

class yellowButtonCstm extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  final Color colore;
  const yellowButtonCstm(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.width,
      required this.colore});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration:
          BoxDecoration(color: colore, borderRadius: BorderRadius.circular(15)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

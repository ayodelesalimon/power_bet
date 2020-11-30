import 'package:flutter/material.dart';

class ButtonTap extends StatelessWidget {
  final String title;
  final IconData img;
  final IconData imgg;
  final Function onTap;
  final Color color;

  const ButtonTap({Key key, this.title, this.img, this.imgg, this.onTap, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              img,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            ),
            Icon(
              imgg,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

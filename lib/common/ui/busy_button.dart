import 'package:flutter/material.dart';

class BusyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool busy;
  final String title;

  const BusyButton({Key key, this.onPressed, this.busy, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      elevation: 0.0,
      color: Colors.blue,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 44,
        child: busy
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}

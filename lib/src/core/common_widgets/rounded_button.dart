import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({Key? key}) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool _isJoined = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isJoined = !_isJoined;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isJoined ? AppColor.primaryColor : Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          _isJoined ? 'Joined' : 'Join',
          style: TextStyle(
            fontSize: 20,
            color: _isJoined ? Colors.white : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

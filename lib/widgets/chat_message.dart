import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.animationController, 
    @required this.texto, 
    @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation( parent: animationController, curve: Curves.easeOut ),
        child: Container(
          child: this.uid == '123'
            ? _myMessage()
            : _otherMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only( bottom: 5, left: 50, right: 8),
        padding: EdgeInsets.all(10),
        child: Text( this.texto, style: TextStyle( color: Colors.white ), ),
        decoration: BoxDecoration( 
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only( bottom: 5, right: 50, left: 8),
        padding: EdgeInsets.all(10),
        child: Text( this.texto, style: TextStyle( color: Colors.black87 ), ),
        decoration: BoxDecoration( 
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
import 'dart:math';
import 'package:card_view_animation/enums.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  ///for animation
  final int speed;
  final bool flipOnTouch;
  final bool isFront;
  final Function(bool) onDirectionChanged;

  ///cardType
  final String cardLogoPath;
  final CardType cardType;

  ///card Text
  final String idTextField;
  final String dataTextField;
  final String nameTextField;
  final String pinTextField;

  ///card Hint
  final String hintCardName;
  final String hintCardPin;
  final String hintCardId;
  final String hintCardDate;

  ///PIN on/off
  final bool containPin;

  ///Colors
  final Color backgroundColor;
  final Color cardFrontColor;
  final Color cardFrontTextColor;
  final Color cardBackColor;
  final Color cardBackPINtextBackgroundColor;
  final Color cardBackPINtextColor;

  CardWidget({
    Key key,
    this.idTextField = '',
    this.pinTextField = '',
    this.dataTextField = '',
    this.nameTextField = '',
    this.cardBackPINtextColor = Colors.black,
    this.cardBackPINtextBackgroundColor = Colors.white,
    this.cardBackColor = Colors.orange,
    this.cardFrontTextColor = Colors.white,
    this.cardFrontColor = Colors.purple,
    this.backgroundColor = Colors.white,
    this.containPin = true,
    this.cardLogoPath = '',
    this.cardType = CardType.none,
    this.flipOnTouch = true,
    this.isFront = true,
    @required this.onDirectionChanged,
    this.speed = 500,
    this.hintCardName = 'Name Lastname',
    this.hintCardDate = 'MM/YY',
    this.hintCardId = 'XXXX XXXX XXXX XXXX',
    this.hintCardPin = 'PIN',
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  ///card's info send from controller
  TextEditingController _idEditingController = TextEditingController();
  TextEditingController _datetextEditingController = TextEditingController();
  TextEditingController _nametextEditingController = TextEditingController();
  TextEditingController _pintextEditingController = TextEditingController();

  ///for animation

  ///cardview text
  String _cardcodetext;
  String _datetext;
  String _nametext;
  String _pin;

  ///card's side
  bool _isFronted = true;

  ///global key for animtation key
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    _isFronted = widget.isFront;
    _cardcodetext = widget.hintCardId;
    _datetext = widget.hintCardDate;
    _nametext = widget.hintCardName;
    _pin = widget.hintCardPin;
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      if (widget.idTextField != '') {
        _cardcodetext = widget.idTextField;
      } else
        _cardcodetext = widget.hintCardId;
      if (widget.dataTextField != '') {
        _datetext = widget.dataTextField;
      } else
        _datetext = widget.hintCardDate;
      if (widget.nameTextField != '') {
        _nametext = widget.nameTextField;
      } else
        _nametext = widget.hintCardName;
      if (widget.pinTextField != '') {
        _pin = widget.pinTextField;
      } else
        _pin = widget.hintCardPin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              animationFrontBack(cardsFrontSide(), cardsBackSide()),
              Expanded(
                  child: Container(
                      child: ListView(
                children: [
                  // cardIdText(),
                  // cardDateText(),
                  // cardNameText(),
                  // if (widget.containPin) cardPinText(),
                ],
              ))),
            ],
          ),
        ));
  }

  Widget cardsFrontSide() {
    return Container(
      decoration: BoxDecoration(
        color: widget.cardFrontColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                child: Image.asset(
                  _checkingCardType(widget.cardType),
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.height / 15,
                ),
              ),
            ],
          ),
          Spacer(),
          Row(children: [
            Text(
              _cardcodetext,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: widget.cardFrontTextColor,
                fontSize: 26,
              ),
            )
          ]),
          Spacer(),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              _datetext,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: widget.cardFrontTextColor,
                fontSize: 18,
              ),
            )
          ]),
          Spacer(),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              _nametext,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: widget.cardFrontTextColor,
                fontSize: 23,
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget cardsBackSide() {
    return Container(
      decoration: BoxDecoration(
        color: widget.cardBackColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 20,
          ),
          Row(
            children: [
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                child: Text(
                  _pin,
                  style: TextStyle(
                      fontSize: 25,
                      backgroundColor: widget.cardBackPINtextBackgroundColor,
                      color: widget.cardBackPINtextColor),
                ),
                alignment: Alignment.center,
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget animationFrontBack(Widget front, Widget back) {
    if (widget.containPin) {
      return FlipCard(
        speed: widget.speed,
        onFlip: () => {
          if (_isFronted)
            {
              _isFronted = false,
            }
          else
            _isFronted = true,
        },
        flipOnTouch: widget.flipOnTouch,
        key: _cardKey,
        front: Container(
          child: front,
        ),
        back: Container(
          child: back,
        ),
      );
    } else
      return front;
  }

  String _checkingCardType(CardType type) {
    if (widget.cardLogoPath == '') {
      switch (type) {
        case CardType.Visa:
          return 'assets/images/Visa_Logo.png';
          break;
        case CardType.AmericanExpress:
          return 'assets/images/americanexpress.png';
          break;
        case CardType.MasterCard:
          return 'assets/images/mastercardpng.png';
          break;
        case CardType.ArCa:
          return 'assets/images/arca.png';
          break;
        default:
          return 'assets/images/Visa_Logo.png';
      }
    } else
      return widget.cardLogoPath;
  }

  ///#card ID
  String getCardId() {
    return _idEditingController.text;
  }

  ///#card active date
  String getCardDate() {
    return _datetextEditingController.text;
  }

  ///#card user name lastname
  String getCardName() {
    return _nametextEditingController.text;
  }

  ///#card Pin
  String getCardPin() {
    return _pintextEditingController.text;
  }
}

class AnimationCard extends StatelessWidget {
  AnimationCard({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);

        transform.rotateY(animation.value);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef void BoolCallback(bool isFront);

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  /// The amount of milliseconds a turn animation will take.
  final int speed;

  final VoidCallback onFlip;
  final BoolCallback onFlipDone;
  final bool flipOnTouch;

  const FlipCard(
      {Key key,
      @required this.front,
      @required this.back,
      this.speed = 500,
      this.onFlip,
      this.onFlipDone,
      this.flipOnTouch = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FlipCardState();
  }
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;

  bool isFront = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: widget.speed), vsync: this);
    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.decelerate)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.decelerate)),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (widget.onFlipDone != null) widget.onFlipDone(isFront);
      }
    });
  }

  void toggleCard() {
    if (widget.onFlip != null) {
      widget.onFlip();
    }
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }

    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        _buildContent(front: true),
        _buildContent(front: false),
      ],
    );

    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: toggleCard,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({@required bool front}) {
    return IgnorePointer(
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        child: front ? widget.front : widget.back,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class NumbersPage extends StatefulWidget {
  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class Data {
  String nome;
  String image;

  Data(this.image, this.nome);
}

class _NumbersPageState extends State<NumbersPage> {
  List<GlobalKey<FlipCardState>> cardStatesKey = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];
  List<bool> cardFlips = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  List<Data> data = List();

  void load() {
    data.add(Data('assets/numbers/one.jpeg', '1'));
    data.add(Data('assets/numbers/ONE.png', '1'));
    data.add(Data('assets/numbers/two.jpeg', '2'));
    data.add(Data('assets/numbers/TWO.png', '2'));
    data.add(Data('assets/numbers/three.jpeg', '3'));
    data.add(Data('assets/numbers/THREE.png', '3'));
    data.add(Data('assets/numbers/four.jpeg', '4'));
    data.add(Data('assets/numbers/FOUR.png', '4'));
    data.add(Data('assets/numbers/five.jpeg', '5'));
    data.add(Data('assets/numbers/FIVE.png', '5'));
    data.add(Data('assets/numbers/six.jpeg', '6'));
    data.add(Data('assets/numbers/SIX.png', '6'));
  }

  bool wait = false;
  int previousIndex = -1;
  bool flip = false;
  int time = 0;
  Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    load();
    data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tempo: $time',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.headline2),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => FlipCard(
                key: cardStatesKey[index],
                onFlip: () {
                  if (!flip) {
                    flip = true;
                    previousIndex = index;
                  } else {
                    flip = false;
                    if (previousIndex != index) {
                      if (data[previousIndex].nome != data[index].nome) {
                        cardStatesKey[previousIndex].currentState.toggleCard();
                        previousIndex = index;
                      } else {
                        cardFlips[previousIndex] = false;
                        cardFlips[index] = false;
                        if (cardFlips.every((t) => t == false)) {
                          timer.cancel();
                          Future.delayed(
                            const Duration(milliseconds:  500),
                            (){
                              showResult();
                          }
                          );
                        }
                      }
                    }
                  }
                },
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: cardFlips[index],
                speed: 800,
                front: Container(
                  child: Image.asset('assets/quest.png'),
                  margin: EdgeInsets.all(4.0),
                  color: Colors.white,
                ),
                back: Container(
                  child: Center(
                    child: Image.asset(
                      '${data[index].image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  margin: EdgeInsets.all(4.0),
                ),
              ),
              itemCount: data.length,
            )
          ],
        ),
      )),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title:
            Text('Você Venceu!', style: Theme.of(context).textTheme.headline3),
        content: Text('Time $time'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => NumbersPage()));
            },
            child: Text('Jogar Novamente'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
            child: Text('Menu'),
          )
        ],
      ),
    );
  }
}

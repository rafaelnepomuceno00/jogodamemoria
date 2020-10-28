import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class ColorsPage extends StatefulWidget {
  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class Data {
  String nome;
  String image;

  Data(this.image, this.nome);
}

class _ColorsPageState extends State<ColorsPage> {
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
    data.add(Data('assets/colors/black.jpeg', '1'));
    data.add(Data('assets/colors/BLACK.png', '1'));
    data.add(Data('assets/colors/green.jpeg', '2'));
    data.add(Data('assets/colors/GREEN.png', '2'));
    data.add(Data('assets/colors/PINK.png', '3'));
    data.add(Data('assets/colors/pink.jpeg', '3'));
    data.add(Data('assets/colors/purple.jpeg', '4'));
    data.add(Data('assets/colors/PURPLE.png', '4'));
    data.add(Data('assets/colors/RED.png', '5'));
    data.add(Data('assets/colors/red.jpeg', '5'));
    data.add(Data('assets/colors/YELLOW.png', '6'));
    data.add(Data('assets/colors/yellow.jpeg', '6'));
  }

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
                          Future.delayed(const Duration(milliseconds: 500), () {
                            showResult();
                          });
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
        content: Text('Tempo: $time segundos'),
        title:
            Text('Você Venceu!', style: Theme.of(context).textTheme.headline3),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => ColorsPage()));
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

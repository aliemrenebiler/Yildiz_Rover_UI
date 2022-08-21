import 'package:flutter/material.dart';

import '../backend/methods/general_methods.dart';
import '../backend/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          primary: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: AspectRatio(
                      aspectRatio: 2.3,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/yildizrover_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                    child: Column(
                      children: [
                        Text(
                          'User Interface',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: roverFontL,
                          ),
                        ),
                        Text(
                          '(Version 1.0)',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(roverGrey),
                            fontWeight: FontWeight.bold,
                            fontSize: roverFontM,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: const InputBox(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: const StartButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/datascreen');
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            color: Color(roverCoral),
            borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
          ),
          child: Text(
            'START',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: roverFontM,
            ),
          ),
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        border: Border.all(
          color: Color(roverGrey),
          width: 3,
        ),
      ),
      child: TextField(
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontSize: roverFontM,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) => {connectedIP = value},
        cursorColor: Color(roverDarkRed),
        controller: textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Connection IP",
          hintStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Color(roverGrey),
            fontSize: roverFontM,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

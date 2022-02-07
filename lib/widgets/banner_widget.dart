import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*.22,
          color: Colors.cyan.shade200,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 1.0,
                          ),
                  DefaultTextStyle(
                    style: GoogleFonts.arvo(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        FadeAnimatedText(
                            'Reach 1 Million+\nCat Lovers',
                          duration: const Duration(seconds: 4),
                        ),
                        FadeAnimatedText(
                            'New way to\nBuy or Sell Cats',
                          duration: const Duration(seconds: 4),
                        ),
                        FadeAnimatedText(
                            'Over 10k+\nCats to Buy!!!',
                          duration: const Duration(seconds: 4),
                        ),
                      ],
                    ),
                  )
                        ],
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          color: Colors.white,

                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/la-mascota-39969.appspot.com/o/banner%2Ficons8-maneki.gif?alt=media&token=aac90b21-4070-48b8-859e-ff2a05181ffd',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.26,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: NeumorphicButton(
                      onPressed: (){

                      },
                      style: NeumorphicStyle(
                        color: Colors.blue.shade800,
                      ),
                      child: Text(
                        "Buy a Cat",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                        ),

                      ),
                    )),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(child: NeumorphicButton(
                      onPressed: (){

                      },
                      style: NeumorphicStyle(
                        color: Colors.blue.shade800,
                      ),
                      child: Text(
                          "Sell a Cat",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                        ),

                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}

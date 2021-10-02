
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:change_app_package_name/change_app_package_name.dart';

//Import des autres onglets
import './_first_tab.dart';
import './_second_tab.dart';
import './_third_tab.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SRisque',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text('1. Evaluation des risques', textAlign: TextAlign.center)),
                Tab(child: Text('2. Inititation de la nutrition', textAlign: TextAlign.center)),
                Tab(child: Text('3. SRI en cours ?', textAlign: TextAlign.center)),
              ],
            ),
            title: const Text('SRIsque'),
          ),
          body: TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    firstTab(),
                  ],
                  addAutomaticKeepAlives: true,
                ),
                ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    secondTab(),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    thirdTab(),
                  ],
                ),
              ],
          ),
        ),
      ),

    );
  }


}


// Méthodes relatives aux visuels des trois onglets


// Classe pour créer les bandeaux et alléger le code dans MyApp en appelant cette classe avec pour arguments: Height, Color, Text
// Note: J'aurais peut-être pu utiliser une méthode de type Container, à voir éventuellement.
/* Container Bandeaux(double a, Color b, String c){

   }

  */
class Bandeaux extends StatelessWidget {

  double hauteur = 0;
  Color? couleur = Colors.red;
  String texte = "";

  Bandeaux(double a, Color? b, String c) {
    this.hauteur = a;
    this.couleur = b;
    this.texte = c;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: this.couleur,
      ),
        height: this.hauteur,
        child: Center(child: Text(this.texte, textAlign: TextAlign.center))
    );
  }
}



// Code des 'Radio Button' (Points cerclés) pour répondre oui ou non
enum YesNoAnswer {oui, non}

class RadioButton extends StatefulWidget {

  List<bool> valeursRadio = [];
  int indextableau = 0;
  String masculin_oui = '';
  String feminin_non = '';
  RadioButton(this.valeursRadio, this.indextableau, this.masculin_oui, this.feminin_non);

  @override
  State<RadioButton> createState() => _RadioButton(valeursRadio, indextableau, masculin_oui, feminin_non);
}

class _RadioButton extends State<RadioButton> {

  List<bool> valeursRadio = [];
  int indextableau = 0;
  String masculin_oui = '';
  String feminin_non = '';
  _RadioButton(this.valeursRadio, this.indextableau, this.masculin_oui, this.feminin_non,);

  YesNoAnswer? _answer = YesNoAnswer.non; //Initialisation

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text(masculin_oui, textAlign: TextAlign.right,),
            trailing: Radio<YesNoAnswer>(
              value: YesNoAnswer.oui,
              groupValue: _answer,
              onChanged: (YesNoAnswer? value) {
                setState(() {
                  _answer = value;
                  valeursRadio[indextableau] = true;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(feminin_non, textAlign: TextAlign.left),
            leading: Radio<YesNoAnswer>(
              value: YesNoAnswer.non,
              groupValue: _answer,
              onChanged: (YesNoAnswer? val) {
                setState(() {
                  _answer = val;
                  valeursRadio[indextableau] = false;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

/////////////////RadioButton 3 states////////////////////////
enum threestates {a, b, c, }
// a -> 'Mineur'
// b -> 'Moyen'
// c -> 'Elevé'

class RadioButton_threestates extends StatefulWidget {

  @override
  State<RadioButton_threestates> createState() => _RadioButton_threestates();
}

class _RadioButton_threestates extends State<RadioButton_threestates> {


  threestates? _answer = threestates.a; //Initialisation

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Radio<threestates>(
                value: threestates.a,
                groupValue: _answer,
                onChanged: (threestates? value) {
                  setState(() {
                    _answer = value;
                    risqueSRI = 0;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('Mineur'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Radio<threestates>(
                value: threestates.b,
                groupValue: _answer,
                onChanged: (threestates? value) {
                  setState(() {
                    _answer = value;
                    risqueSRI = 1;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('Moyen'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Radio<threestates>(
                value: threestates.c,
                groupValue: _answer,
                onChanged: (threestates? value) {
                  setState(() {
                    _answer = value;
                    risqueSRI = 2;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('Elevé'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


/////////////////RadioButton 4 states////////////////////////
enum fourstates {a, b, c, d}
// a -> '< 5 jours'
// b -> '> 5 jours'
// c -> '> 10 jours'
// d -> '> 15 jours'

class RadioButton_fourstates extends StatefulWidget {

  @override
  State<RadioButton_fourstates> createState() => _RadioButton_fourstates();
}

class _RadioButton_fourstates extends State<RadioButton_fourstates> {


  fourstates? _answer = fourstates.a; //Initialisation

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
                Radio<fourstates>(
                  value: fourstates.a,
                  groupValue: _answer,
                  onChanged: (fourstates? value) {
                    setState(() {
                      _answer = value;
                      prise_alimentaire = 0;
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text('< 5 jours'),
                ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Radio<fourstates>(
                value: fourstates.b,
                groupValue: _answer,
                onChanged: (fourstates? value) {
                  setState(() {
                    _answer = value;
                    prise_alimentaire = 5;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('> 5 jours')
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Radio<fourstates>(
                value: fourstates.c,
                groupValue: _answer,
                onChanged: (fourstates? value) {
                  setState(() {
                    _answer = value;
                    prise_alimentaire = 10;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('> 10 jours'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Radio<fourstates>(
                value: fourstates.d,
                groupValue: _answer,
                onChanged: (fourstates? value) {
                  setState(() {
                    _answer = value;
                    prise_alimentaire = 15;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text('> 15 jours'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SnackPoids extends StatelessWidget {

  int index = 0;
  List<double> valeurs = [];

  SnackPoids(int a, List<double> b) {
    this.index = a;
    this.valeurs = b;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 50,
          width: 10000,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Scaffold(
            body: Center(
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  if(text == '') {
                    valeurs[index] = valeursInitialesTab1[index];
                  }else {
                    print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
                    valeurs[index] = double.parse(text);
                  }
                  print(valeurs[index]);
                },
                onSubmitted: (text){
                  if(index == 3 && valeursTab_1[1] == 80.2222) {
                    if(text != "") {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 6),
                        content: Container(
                          height: 80, // Hauteur de la SnackBar
                          child: const Center(
                            child: Text("La classification du risque lié à la perte de poids dépend du poids du patient, veillez à remplir le champ 'Poids du patient (kg)'.",
                              style: TextStyle(fontSize: 16), //TODO : Ajuster la police
                              textAlign: TextAlign.center,

                            ),
                          ),
                        ),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {

                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {

                    }

                  }else {

                  }
                },
              ),
            ),
          ),
        );
  }
}



TextField Zone_De_Texte1 (int index, List<double> valeurs) {

  return TextField(
    keyboardType: TextInputType.numberWithOptions(),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    onChanged: (text) {
      if(text == '') {
        valeurs[index] = valeursInitialesTab1[index];
      }else {
        print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
        valeurs[index] = double.parse(text);
      }
      print(valeurs[index]);
    },
  );
}

TextField Zone_De_Texte2 (int index, List<double> valeurs) {

  return TextField(
    keyboardType: TextInputType.numberWithOptions(),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    onChanged: (text) {
      if(text == '') {
        valeurs[index] = valeursInitialesTab2[index];
      }else {
        print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
        valeurs[index] = double.parse(text);
      }
      print(valeurs[index]);
    },
  );
}

TextField Zone_De_Texte3 (int index, List<double> valeurs) {

  return TextField(
    keyboardType: TextInputType.numberWithOptions(),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    onChanged: (text) {
      if(text == '') {
        valeurs[index] = valeursInitialesTab3[index];
      }else {
        print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
        valeurs[index] = double.parse(text);
      }
      print(valeurs[index]);
    },
  );
}

TextField Zone_De_Texte_Ligne1 (int index, String name, List<double> valeurs) {

  return TextField(
    keyboardType: TextInputType.numberWithOptions(),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: name,
    ),

    onChanged: (text) {
      if(text == '') {
        valeurs[index] = valeursInitialesTab1[index];
      }else {
        print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
        valeurs[index] = double.parse(text);
      }
      print(valeurs[index]);
      },

  );
}

TextField Zone_De_Texte_Ligne3 (int index, String name, List<double> valeurs) {

  return TextField(
    keyboardType: TextInputType.numberWithOptions(),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: name,
    ),

    onChanged: (text) {
      if(text == '') {
        valeurs[index] = valeursInitialesTab3[index];
      }else {
        print('First Text Field : $text'); //Ne pas oublier de l'enlever un jour
        valeurs[index] = double.parse(text);
      }
      print(valeurs[index]);
    },

  );
}

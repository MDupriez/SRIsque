


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';


//Import des autres onglets
import 'main.dart';




List<bool> valeursRadioTab_2 = [false, false, false, false];
// 0 -> ECG réalisé
// 1 -> Biologie prénutrition réalisée
// 2 -> Supplémentation prescrite
// 3 -> Type de nutrition (Entérale/Parentérale)


List<double> valeursTab2 = [2, 80];
// 0 -> Taille (m)
// 1 -> Poids (kg)


List<double> valeursInitialesTab2 = [2, 80];
// 0 -> Taille du patient (m) (Onglet 2)
// 1 -> Poids du patient (kg) (Onglet 2)


int risqueSRI = 0;

// TODO: Initialiser les valeurs de façon pertinente

//Widgets contenus dans le second onglet. Mis dans un StatefulWidget pour
//éviter la destruction des données une fois hors de l'écran.
class secondTab extends StatefulWidget {
  @override
  _secondTabState createState() => _secondTabState();
}

class _secondTabState extends State<secondTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 75,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Etape n°1 : ',
                  style: TextStyle(fontSize: 25)
              ),
            ),
        ),
        Bandeaux(50, Colors.amber[600], 'ECG réalisé :'),
        RadioButton(valeursRadioTab_2, 0, 'Oui', 'Non'),
        Bandeaux(80, Colors.amber[600], 'Biologie prénutrition réalisée (NFS, CRP, bilan hépathique complet, '
            'ionogramme complet y compris Mg/P/Ca, vitamines B12/B9/D, pré albumine et albumine, urée, créatinine) :'),
        RadioButton(valeursRadioTab_2, 1, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Supplémentation prescrite à mon patient ("prénutrition" dans l"EPR) :'),
        RadioButton(valeursRadioTab_2, 2, 'Oui', 'Non'),
        Container(
            height: 75,
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Etape n°2 : ',
                  style: TextStyle(fontSize: 25)
              ),
            )
        ),
        Bandeaux(50, Colors.amber[600], 'Risque de SRI :'),
        RadioButton_threestates(),
        Bandeaux(50, Colors.amber[600], 'Taille (m) :'),
        Zone_De_Texte2(0, valeursTab2),
        Bandeaux(50, Colors.amber[600], 'Poids (kg) :'),
        Zone_De_Texte2(1, valeursTab2),
        Bandeaux(50, Colors.amber[600], 'Type de nutrition :'),
        RadioButton(valeursRadioTab_2, 3, 'Entérale', 'Parentérale'),
        Bandeaux(2, Colors.blueAccent, ''),
        BoutonCalcul_Resultats_tab2(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}



class BoutonCalcul_Resultats_tab2 extends StatefulWidget {

  @override
  _BoutonCalcul_Resultats_tab2State createState() => _BoutonCalcul_Resultats_tab2State();
}

class _BoutonCalcul_Resultats_tab2State extends State<BoutonCalcul_Resultats_tab2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Scaffold(
        body: Center(
          child: OutlinedButton(

            style: OutlinedButton.styleFrom(
              fixedSize: Size(300, 50),
            ),

            onPressed: () {
              if(!valeursRadioTab_2[0] || !valeursRadioTab_2[1] || !valeursRadioTab_2[2]) {
                final snackBar = SnackBar(
                  content: Container(
                    height: 80, // Hauteur de la SnackBar
                    child: const Center(
                      child: Text("Attention à bien réaliser les trois points de l'étape n°1 avant de passer à l'étape n°2",
                        style: TextStyle(fontSize: 18), //TODO : Ajuster la police
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) => boiteDeDialogue(),
                );


                //Appeler méthode AlertDialog
              }
            },
            child: Text('Calcul', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        )

      )


    );
  }
}



Dialog boiteDeDialogue() {

  List<String> nbJoursTableau = ["1 jour","2 jours"];
  List<String> nutritionTableau = ["entérale", "parentérale"];

  String nbJours = "1 jour";
  String nutrition = "parentérale";

  if (risqueSRI == 0) {
    nbJours = nbJoursTableau[0];
  } else {
    nbJours = nbJoursTableau[1];
  }

  if(valeursRadioTab_2[3] == true) {     //valeursRadioTab_2 -> (entérale/parentérale)
    nutrition = nutritionTableau[0];
  } else {
    nutrition = nutritionTableau[1];
  }



  return Dialog(

      insetPadding: const EdgeInsets.all(5),
      child: Stack(
          children: <Widget>[
            Container(
              color: Colors.blue,
              width: 430,
              height: 410,
              padding: const EdgeInsets.all(5),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Plan de nutrition :',
                    style: TextStyle(
                      color: Colors.white,
                        fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),

                  ),
                  Container(
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber[600],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('1. Commencer la supplémentation "prénutrition" \n' + nbJours +
                            ' AVANT la nutrition selon le schéma pré-encodé dans l"EPR',
                          textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      //borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Text('2. Nutrition ' + nutrition,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold)) //Caractères gras
                    ),
                  ),


                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )
                            ),
                            child: Center(
                              child: Text('Jour ' + valeursJours(risqueSRI)[0] + ':\n' + valeursNutrition(valeursTab2[0], valeursTab2[1], valeursRadioTab_2[3])[0].toString() + ' ml',
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border.symmetric(vertical: BorderSide(color: Colors.black))
                            ),
                            child: Center(
                              child: Text('Jour ' + valeursJours(risqueSRI)[1] + ':\n' + valeursNutrition(valeursTab2[0], valeursTab2[1], valeursRadioTab_2[3])[1].toString() +' ml',
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )
                            ),
                            child: Center( //TODO: Peut être élargir "à partir du jour" semble un peu à l'étroit
                              child: Text('A partir du jour ' + valeursJours(risqueSRI)[2] + ':\n' + valeursNutrition(valeursTab2[0], valeursTab2[1], valeursRadioTab_2[3])[2].toString() + ' ml',
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),

                      ],
                    )
                  ),
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      //borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text('Biologie quotidienne avec ionogramme complet \n (y compris P et Mg)'
                            ' les 5 premiers jours de \n la nutrition et surveillance clinique pour exclure un SRI (Cf. onglet suivant)',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)) //Caractères gras
                    ),
                  ),

                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      //borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Text(remarqueParenterale(valeursRadioTab_2[3]),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)) //Caractères gras
                    ),
                  ),






                ]
              )
            )
          ]
      )
  );

}

//Affichage (ou non) de la remarque associée au type de nutrition parentérale
String remarqueParenterale(bool parenteraleEnterale) {

  String remarque = "";

  if(parenteraleEnterale == false) {
    remarque = "Attention: si prescription de SmofKaviben 8g>1000ml/24h:"
        "contacter d'emblée l'équipe de Nutrition (A.Ballarin 5578 / J.Thomas 5496)";
  }else {
    remarque = "";
  }

  return remarque;
}



List<String> valeursJours(int risque) { // La valeur des jours est différente selon le risque

  List<String> jours = ["", "", ""];

  if(risque == 0) {
    jours[0] = '1-3';
    jours[1] = '4-6';
    jours[2] = '7';
  } else {
    jours[0] = '1-2';
    jours[1] = '3-5';
    jours[2] = '6';
  }

  return jours;
}




List<int> valeursNutrition(double taille, double poids, bool parenteraleEnterale) {

  List<int> valeursNutritionTableau = [4, 0, 0];
  int indexPoids = 0;

  print(valeursRadioTab_2[3]);
  print(parenteraleEnterale);
  print(risqueSRI);

  double BMI = poids/(taille*taille);
  double poidsIdealSousPoids = 22 * taille * taille; //22 -> BMI idéal moyen (moyenne de 19 et 25)
  double poidsIdealObese = poidsIdealSousPoids + 0.25 * (poids - poidsIdealSousPoids);

  if (BMI < 18.5) {
    poids = poidsIdealSousPoids;
  } else if (BMI > 30) {
    poids = poidsIdealObese;
  }

  List<double> poidsTableauRef = [28,29,30,31,32,33,34,35,36,37,38,39,40,42,44,46,48,50,55,60,65,70,75,80,85,90,95,100];
  List<double> indexPoidsTableau = List.filled(28, 0);

  for(int i = 0; i < 28; i++) {
    indexPoidsTableau[i] = poidsTableauRef[i] - poids; //TODO: Je crois qu'il faut trouver un moyen d'effacer les anciennes valeurs rentrées dans l'application
  }

  int indexPoids1 = indexPoidsTableau.indexWhere((element) => element == 0);
  int indexPoids2 = indexPoidsTableau.indexWhere((element) => element >= 0);

  print(taille);
  print(poids);
  print(indexPoidsTableau);
  print(indexPoids1);
  print(indexPoids2);


  if(indexPoids1 == -1) {
    indexPoids = indexPoids2 - 1;
  } else {
    indexPoids = indexPoids1;
  }

  print(indexPoids);



  List<List<int>> enterale = [
    [200,200,200,250,250,250,250,300,300,300,300,300,300,300,350,350,400,400,400,450,500,550,600,600,650,700,700,750],
    [300,300,350,350,400,400,400,400,400,400,450,450,450,500,500,500,550,600,600,700,750,800,850,900,950,1000,1100,1150],
    [400,450,450,500,500,500,500,550,550,550,600,600,600,650,700,700,700,750,800,900,1000,1100,1150,1200,1300,1350,1350,1500],
    [500,550,600,600,600,600,650,650,700,700,700,750,750,800,800,900,900,950,1050,1150,1200,1300,1400,1500,1600,1700,1800,1900],
    [650,650,700,700,700,750,750,800,800,850,850,900,900,950,1000,1000,1000,1100,1250,1350,1450,1600,1700,1800,1900,2050,2150,2250],
  ];

  List<List<int>> parenterale = [
    [300,300,350,350,350,400,400,400,400,400,400,450,450,500,500,500,550,550,600,700,750,800,850,900,950,1000,1050,1100],
    [500,500,500,500,550,550,600,600,600,600,650,650,700,700,750,800,800,850,900,1000,1100,1200,1250,1350,1450,1500,1600,1700],
    [600,650,700,700,700,750,800,800,800,850,850,900,900,950,1000,1050,1100,1100,1250,1350,1500,1600,1700,1800,1900,2000,2150,2250],
    [800,800,850,900,900,900,950,1000,1000,1050,1100,1100,1100,1200,1250,1300,1350,1400,1550,1700,1800,2000,2100,2250,2400,2500,2700,2800],
    [950,950,1000,1050,1100,1100,1150,1200,1200,1250,1300,1300,1350,1400,1500,1550,1600,1650,1850,2000,2200,2350,2500,2700,2850,3050,3200,3350],
  ];


  print(enterale[0][18]);


  if(risqueSRI == 0) {
    if(parenteraleEnterale == true) {  //parenteraleEnterale == true veut dire que le type de nutrition est entérale.
      valeursNutritionTableau = [enterale[2][indexPoids], enterale[3][indexPoids], enterale[4][indexPoids]];
    }else {
      valeursNutritionTableau = [parenterale[2][indexPoids], parenterale[3][indexPoids], parenterale[4][indexPoids]];
    }
  }else if(risqueSRI == 1) {
    if(parenteraleEnterale == true) {
      valeursNutritionTableau = [enterale[1][indexPoids], enterale[2][indexPoids], enterale[3][indexPoids]];
    }else {
      valeursNutritionTableau = [parenterale[1][indexPoids], parenterale[2][indexPoids], parenterale[3][indexPoids]];
    }
  }else if(risqueSRI == 2) {
    if(parenteraleEnterale == true) {
      valeursNutritionTableau = [enterale[0][indexPoids], enterale[1][indexPoids], enterale[2][indexPoids]];
    }else {
      valeursNutritionTableau = [parenterale[0][indexPoids], parenterale[1][indexPoids], parenterale[2][indexPoids]];
    }
  }


  print(valeursNutritionTableau);

  return valeursNutritionTableau;
}








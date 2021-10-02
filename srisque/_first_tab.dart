
import 'package:flutter/material.dart';

//Import des autres onglets
import 'main.dart';


//Widgets contenus dans le premier onglet. Mis dans un StatefulWidget pour
//éviter la destruction des données une fois hors de l'écran.
class firstTab extends StatefulWidget {
  @override
  _firstTabState createState() => _firstTabState();
}

class _firstTabState extends State<firstTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bandeaux(50, Colors.amber[600], 'Sexe du patient :'),
        RadioButton(valeursRadioTab_1, 0, 'Masculin', 'Féminin'),
        Bandeaux(50, Colors.amber[600], 'Taille du patient (m) :'),
        Zone_De_Texte1(0, valeursTab_1),
        Bandeaux(50, Colors.amber[600], 'Poids du patient (kg) :'),
        Zone_De_Texte1(1, valeursTab_1),
        Bandeaux(50, Colors.amber[600], 'Consommation éthylique (unités/j) :'),
        Zone_De_Texte1(2, valeursTab_1),
        Bandeaux(50, Colors.amber[600], 'Perte de poids endéans les 3-6 mois (kg) :'),
        SnackPoids(3, valeursTab_1),
        Bandeaux(50, Colors.amber[600], 'Taux plasmatique du K, P, Mg (mmol/L) :'),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Zone_De_Texte_Ligne1(4, 'K', valeursTab_1),
              ),
              Expanded(
                child: Zone_De_Texte_Ligne1(5, 'P', valeursTab_1),
              ),
              Expanded(
                child: Zone_De_Texte_Ligne1(6, 'Mg', valeursTab_1),
              ),
            ]
        ),
        Bandeaux(50, Colors.amber[600], 'Peu ou aucune prise alimentaire depuis une durée :'),
        RadioButton_fourstates(),
        Bandeaux(50, Colors.amber[600], 'Vomissements'),
        RadioButton(valeursRadioTab_1, 1, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Traitement par diurétiques'),
        RadioButton(valeursRadioTab_1, 2, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Antécédents de chirurgie bariatrique'),
        RadioButton(valeursRadioTab_1, 3, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Cancer actif'),
        RadioButton(valeursRadioTab_1, 4, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Syndrome du grêle court'),
        RadioButton(valeursRadioTab_1, 5, 'Oui', 'Non'),
        Bandeaux(50, Colors.amber[600], 'Séjour aux soins intensifs > 72h (au cours de cette hospitalisation)'),
        RadioButton(valeursRadioTab_1, 5, 'Oui', 'Non'),
        Bandeaux(2, Colors.blueAccent, ''),
        Bandeaux(4, Colors.white, ''),
        BoutonCalcul_Resultats(),

      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}


// TODO : Pour K, P, Mg, ils gardent la valeur précédemment rentrée lorsque l'on
// TODO : efface cette valeur. Le problème étant que l'on peut être tenté de croire
// TODO : qu'en laissant les champs vides, on met la valeur de ces champs à zéro ou
// TODO : qu'il ne sont plus pris en compte dans le calcul du risque, mais il n'en
// TODO : est rien.
// TODO : A voir comment résoudre ça en fonction de comment doit être utilisée l'application.

//Variables Globales
int sexe_du_patient = 0; // TODO: Voir si je peux le virer
int prise_alimentaire = 0; //Correspond au bandeaux: 'Peu ou aucune prise alimentaire depuis une durée :'
int graviteRisque = 0;

List<bool> valeursRadioTab_1 = [false, false, false, false, false, false, false]; //Choix binaire (Oui/Non ou Masculin/Féminin)
// 0 -> Sexe du patient
// 1 -> Vomissements
// 2 -> Traitements par diurétiques
// 3 -> Antécédents de chirurgie bariatrique
// 4 -> Cancer actif
// 5 -> Syndrôme du grêle court
// 6 -> Séjour aux soins intensifs > 72h (au cours de cette hospitalisation



int tile_resultats = 34; //TODO: Semble inutile
String Texte= ''; //Voir si ça sert encore à quelque chose
List<double> valeursTab_1 = [2, 80.2222, 0, 0, 4, 1, 1];
// 0 -> Taille du patient (m)
// 1 -> Poids du patient (kg)
// 2 -> Consommation éthylique (unités/j)
// 3 -> Perte de poids endéans les 3-6 mois (kg)
// 4 -> K (Taux plasmatique)
// 5 -> P (Taux plasmatique)
// 6 -> Mg (Taux plasmatique)

List<double> valeursInitialesTab1 = [2, 80.2222, 0, 0, 4, 1, 1];
// 0 -> Taille du patient (m) (Onglet 1)
// 1 -> Poids du patient (kg) (Onglet 1)
// 2 -> Consommation éthylique (unités/j)
// 3 -> Perte de poids endéans les 3-6 mois (kg)
// 4 -> K (Taux plasmatique) (Onglet 1)
// 5 -> P (Taux plasmatique) (Onglet 1)
// 6 -> Mg (Taux plasmatique) (Onglet 1)







int RiskEval(double taillePatient, double poidsPatient, double ethylique, double pertePoids, double K, double P, double Mg,
    bool sexePatient, bool vomissements, bool diuretiques, bool bariatrique, bool cancer,
    bool syndromeGrele, bool reanimation, int priseAlimentaire) {


  List<int> Risk = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  print(valeursTab_1);
  print(poidsPatient);

  //Risque associé au BMI :
  double BMI = poidsPatient/(taillePatient*taillePatient);
  List<double> BMIseuils = [BMI - 18.5, BMI - 16, BMI - 14];
  Risk[0] = (BMIseuils.where((BMIseuils) => BMIseuils < 0).toList()).length;

  //Risque associé à la perte de poids en pourcentage :
  double pourcentagePerte = 100 * (pertePoids/ poidsPatient);
  List<double> PerteSeuils = [10 - pourcentagePerte, 15 - pourcentagePerte, 20 - pourcentagePerte];
  Risk[1] = (PerteSeuils.where((PerteSeuils) => PerteSeuils < 0).toList()).length;

  //Risque associé au nb de jours sans prise alimentaire
  List<int> Nbjours = [5 - priseAlimentaire, 10 - priseAlimentaire, 15 - priseAlimentaire];
  Risk[2] = (Nbjours.where((Nbjours) => Nbjours <= 0).toList()).length;

  //print(priseAlimentaire);

  //Risque associé aux vomissements
  if (vomissements == true) {
    Risk[3] = 1;
  } else {
    Risk[3] = 0;
  }

  //Risque associé aux antécédents de chirurgie bariatrique
  if (bariatrique == true) {
    Risk[4] = 2;
  } else {
    Risk[4] = 0;
  }

  //Risque associé aux taux plasmatiques (K, P, Mg)
  if (K < 3.5 || P < 0.8 || Mg < 0.75) {
    Risk[5] = 2;
  } else {
    Risk[5] = 0;
  }

  //Risque associé aux soins intensifs (réanimation)
  if (reanimation == true) {
    Risk[6] = 3;
  } else {
    Risk[6] = 0;
  }

  //Risque associé à la consommation éthylique
  if (sexePatient == true) {
    if (ethylique > 5) {
      Risk[7] = 1;
    } else {
      Risk[7] = 0;
    }
  } else if (sexePatient == false) {
    if (ethylique > 3) {
      Risk[7] = 1;
    } else {
      Risk[7] = 0;
    }
  }

  //Risque associé à un traitement par diurétiques
  if (diuretiques == true) {
    Risk[8] = 1;
  } else {
    Risk[8] = 0;
  }

  //Risque associé à un cancer
  if (cancer == true) {
    Risk[9] = 2;
  } else {
    Risk[9] = 0;
  }

  //Risque associé au syndrome du grêle court
  if (syndromeGrele == true) {
    Risk[10] = 3;
  } else {
    Risk[10] = 0;
  }

  print(Risk);

  int RiskZero = (Risk.where((Risk) => Risk == 0).toList()).length;
  int RiskMin = (Risk.where((Risk) => Risk == 1).toList()).length;
  int RiskMoyen = (Risk.where((Risk) => Risk == 2).toList()).length;
  int RiskMax = (Risk.where((Risk) => Risk == 3).toList()).length;

  if (RiskMax != 0 || RiskMoyen >= 2) {
    graviteRisque = 3;
  } else if (RiskMoyen != 0 || RiskMin >= 2) {
    graviteRisque = 2;
  } else if (RiskMin != 0) {
    graviteRisque = 1;
  } else if (RiskZero != 0) {
    graviteRisque = 0;
  }

  print(graviteRisque);

  return graviteRisque;
}

class BoutonCalcul_Resultats extends StatefulWidget {


  @override
  _BoutonCalcul_ResultatsState createState() => _BoutonCalcul_ResultatsState();
}

class _BoutonCalcul_ResultatsState extends State<BoutonCalcul_Resultats> {

  Color color = Colors.grey;
  String risqueResultats = '';
  String ongletDeux = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      //width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 100,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    RiskEval(valeursTab_1[0], valeursTab_1[1], valeursTab_1[2], valeursTab_1[3], valeursTab_1[4],
                        valeursTab_1[5], valeursTab_1[6],
                        valeursRadioTab_1[0], valeursRadioTab_1[1], valeursRadioTab_1[2], valeursRadioTab_1[3],
                        valeursRadioTab_1[4], valeursRadioTab_1[5], valeursRadioTab_1[6], prise_alimentaire);
                    if(graviteRisque == 3) {
                      color = Colors.red;
                      risqueResultats = 'Risque élevé';
                      ongletDeux = 'Voir onglet n°2';
                    } else if (graviteRisque == 2) {
                      color = Colors.deepOrangeAccent;
                      risqueResultats = 'Risque moyen';
                      ongletDeux = 'Voir onglet n°2';
                    } else if (graviteRisque == 1) {
                      color = Colors.orangeAccent;
                      risqueResultats = 'Risque mineur';
                      ongletDeux = 'Voir onglet n°2';
                    } else if(graviteRisque == 0) {
                      color = Colors.green;
                      risqueResultats = 'Risque négligeable';
                      ongletDeux = '';
                    }

                  });
                },
                child: Text('Calcul'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(risqueResultats),
                  ),
                  Center(
                    child: Text(ongletDeux),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}



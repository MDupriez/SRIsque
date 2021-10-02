
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Import des autres onglets
import'./main.dart';


List<bool> valeursRadioTab_3 = [false];
// 0 -> Oedèmes

List<double> valeursTab_3 = [10, 50, 4, 0.9, 0.8, 50, 10, 0];
// 0 -> Taux initial de phosphore (mmol/L)
// 1 -> Apport journalier en phosphore (mEq/jour)
// 2 -> K
// 3 -> P
// 4 -> Mg
// 5 -> Fréquence cardiaque (bpm)
// 6 -> Fréquence respiratoire ( /min)
// 7 -> Prise de poids (kg/semaine)

List<double> valeursInitialesTab3 = [10, 50, 4, 0.9, 0.8, 50, 10, 0];
// 0 -> Taux initial de phosphore (mmol/L)
// 1 -> Apport journalier en phosphore (mEq/jour)
// 2 -> K
// 3 -> P
// 4 -> Mg
// 5 -> Fréquence cardiaque (bpm)
// 6 -> Fréquence respiratoire ( /min)
// 7 -> Prise de poids (kg/semaine)



bool biologie = false;
bool clinique = false;

class thirdTab extends StatefulWidget {
  @override
  _thirdTabState createState() => _thirdTabState();
}

class _thirdTabState extends State<thirdTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bandeaux(50, Colors.amber[600], 'Taux initial de phosphore (mmol/L) :'),
        Zone_De_Texte3(0, valeursTab_3),
        Bandeaux(50, Colors.amber[600], 'Apport journalier en phosphore (mEq/jour) :'),
        Zone_De_Texte3(1, valeursTab_3),
        Bandeaux(50, Colors.amber[600], 'Taux plasmatique du K, P, Mg (mmol/L) :'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Zone_De_Texte_Ligne3(2, 'K', valeursTab_3),
            ),
            Expanded(
              child: Zone_De_Texte_Ligne3(3, 'P', valeursTab_3),
            ),
            Expanded(
              child: Zone_De_Texte_Ligne3(4, 'Mg', valeursTab_3),
            ),
          ],
        ),
        Bandeaux(50, Colors.amber[600], 'Fréquence cardiaque (bpm) :'),
        Zone_De_Texte3(5, valeursTab_3),
        Bandeaux(50, Colors.amber[600], 'Fréquence respiratoire ( /min) :'),
        Zone_De_Texte3(6, valeursTab_3),
        Bandeaux(50, Colors.amber[600], 'Prise de poids (kg/semaine) :'),
        Zone_De_Texte3(7, valeursTab_3),
        Bandeaux(50, Colors.amber[600], "Apparition ou majoration d'œdèmes :"),
        RadioButton(valeursRadioTab_3, 0, 'Oui', 'Non'),
        Bandeaux(2, Colors.blueAccent, ''),
        Bandeaux(4, Colors.white, ''),
        BoutonCalcul_Resultats_tab3(),


      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class BoutonCalcul_Resultats_tab3 extends StatefulWidget {

  @override
  _BoutonCalcul_Resultats_tab3State createState() => _BoutonCalcul_Resultats_tab3State();
}

class _BoutonCalcul_Resultats_tab3State extends State<BoutonCalcul_Resultats_tab3> {

  Color color = Colors.grey;
  int typeDeRisque = 0;
  String risqueSRIResultats = '';
  String priseEnCharge = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    //Fonction retournant le risque
                    SRIEnCours(valeursTab_3[0], valeursTab_3[1], valeursTab_3[2], valeursTab_3[3], valeursTab_3[4],
                        valeursTab_3[5], valeursTab_3[6], valeursTab_3[7], valeursRadioTab_3[0]);

                    if(biologie ==false && clinique == false) {
                      typeDeRisque = 0; //Pas de SRI
                      risqueSRIResultats = 'Pas de SRI';
                      priseEnCharge = '';
                      color = Colors.green;
                    } else if(biologie == true && clinique == false) {
                      typeDeRisque = 1; //SRI imminent
                      risqueSRIResultats = 'SRI imminent';
                      priseEnCharge = 'Cliquer pour prise en charge';
                      color = Colors.orange;
                    } else if(biologie == true && clinique == true) {
                      typeDeRisque = 2; //SRI confirmé
                      risqueSRIResultats = 'SRI confirmé';
                      priseEnCharge = 'Cliquer pour prise en charge';
                      color = Colors.red;
                    }
                  });
                },
                child: const Text('Calcul'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: OutlinedButton(
                onPressed: () {
                  ButtonPressed();
                },
                child: Column(
                  children: [
                    Expanded(
                      child:Center(
                          child: Text(risqueSRIResultats + '\n' + priseEnCharge,
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          )
                      ),
                    )


                  ],
                ),
                //return null dans le on pressed pour disable le bouton
              )


            ),
          )
        ],
      ),
    );


  }


  Function? ButtonPressed(){

    if (typeDeRisque == 0){
      return null;
    } else {
      if(typeDeRisque == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) => boiteDeDialogue_tab3(typeDeRisque), //TODO: Créer 'boîte de Dialogue'
        );

      }else if (typeDeRisque == 2) {
        showDialog(
          context: context,
          builder: (BuildContext context) => boiteDeDialogue_tab3(typeDeRisque), //TODO: Créer 'boîte de Dialogue'
        );
      }
    }



  }


}


Dialog boiteDeDialogue_tab3(int typeDeRisqueDialogue) {

  String nomFichierImage = '';

  if(typeDeRisqueDialogue == 1) {
    nomFichierImage = 'assets/Image_SRI_imminent.jpg';
  } else if (typeDeRisqueDialogue == 2) {
    nomFichierImage = 'assets/Image_SRI_confirme.jpg';
  }



  return Dialog(
    insetPadding: const EdgeInsets.fromLTRB(5, 210, 5, 210),
    child: Stack(
      children: [
        Container(
          color: Colors.blue,
          child: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1,
              child: Image.asset(nomFichierImage),
            )
          ),
        )
      ],
    ),
  );
}









List<bool> SRIEnCours(double phosphoreInitial, double apportJournalier,  double K, double P, double Mg,
     double frequenceCardiaque, double frequenceRespiratoire, double priseDePoids, bool oedemes) {




  //Risque biologie
  List<double> tauxPlasmatiquesSeuils = [K - 3.5, P - 0.8, Mg - 0.75];
  int tauxPlasmatiquesRisque = (tauxPlasmatiquesSeuils.where((element) => element < 0).toList()).length;

  if(P < (0.7 * phosphoreInitial) || P < 0.6) {
    biologie = true;
  } else {
    if(apportJournalier >= 90) {
      biologie = true;
    } else {
      if(tauxPlasmatiquesRisque >= 2) {
        biologie = true;
      } else {
        biologie = false;
      }
    }
  }

  //Risque clinique
  if(oedemes == true || priseDePoids > 1.5) {
    clinique = true;
  } else {
    if(frequenceCardiaque > 100) {
      clinique = true;
    } else {
      if(frequenceRespiratoire > 20) {
        clinique = true;
      } else {
        clinique = false;
      }
    }
  }


  List<bool> biologieClinique = [biologie, clinique];

  return biologieClinique;
}















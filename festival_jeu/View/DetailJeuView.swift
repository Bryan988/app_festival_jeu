//
// Created by user190484 on 28/03/2021.
//

import Foundation
import SwiftUI

struct DetailJeuView: View{
    var jeu : JeuViewModel
    private var prototype : String

    init(jeu : JeuViewModel){
        self.jeu = jeu
        self.prototype = (jeu.prototype ? "Oui" : "Non")
    }

    var body: some View{
            VStack{
                Text("\(jeu.libelleJeu)").font(.title)
                Spacer()
                Text("Editeur du jeu : \(jeu.nomPersonne)")
                HStack{
                    Image(systemName: "person.3.fill").resizable().frame(width: 36,height: 36)
                    Text("\(jeu.nombreJoueur) joueurs - ")
                    Text("\(jeu.ageMinimum) ans")

                }
                HStack{
                    Image(systemName: "clock").resizable().frame(width: 36,height: 36)
                    Text("\(jeu.duree) - ")
                    Text("Prototype : \(prototype)")
                }
                Spacer()

            }

    }
}
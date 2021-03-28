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
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                Text("\(jeu.libelleJeu)").font(.title)
                Spacer()
                Text("Editeur du jeu : \(jeu.nomPersonne)")
                HStack{
                    Image(systemName: "person.3.fill")
                    Text("\(jeu.nombreJoueur) joueurs - ")
                    Text("\(jeu.ageMinimum) ans")

                }
                HStack{
                    Image(systemName: "clock")
                    Text("\(jeu.duree) - ")
                    Text("Prototype : \(prototype)")
                }

                Spacer()
            }
    }
}
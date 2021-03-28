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
                Text("Nom du jeu : \(jeu.libelleJeu)").font(.headline)
                Text("Editeur du jeu : \(jeu.nomPersonne)")
                Text("Nombre de joueur : \(jeu.nombreJoueur)")
                Text("Âge minimum : \(jeu.ageMinimum)")
                Text("Durée : \(jeu.duree)")
                Text("Prototype : \(prototype)")
            }
    }
}
//
// Created by user190484 on 28/03/2021.
//

import Foundation

class EditeurViewModel:Identifiable{
    let id = UUID()
    private var editeur:Editeur
    private(set) var nomPersonne:String
    private(set) var games:[Jeu]

    init(editeur: Editeur) {
        self.editeur=editeur
        self.nomPersonne = editeur.nomPersonne
        self.games = editeur.games
    }
}
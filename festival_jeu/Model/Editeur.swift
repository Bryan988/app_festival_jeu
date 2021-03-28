//
// Created by user190484 on 28/03/2021.
//

import Foundation

class Editeur {
    private(set) var nomPersonne:String
    private(set) var games:[Jeu]

    init(nomPersonne: String, games: [Jeu]) {
        self.nomPersonne = nomPersonne
        self.games = games
    }

}
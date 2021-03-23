//
// Created by etud on 23/03/2021.
//

import Foundation

class Jeu {
    private(set) var libelleJeu:String
    private(set) var nombreJoueur:String
    private(set) var ageMinimum:Int
    private(set) var duree:String
    private(set) var prototype:Bool
    private(set) var nomPersonne:String

    init(nomJeu: String, nombreJoueur: String, ageMinimum: Int, duree: String, prototype: Bool,nomPersonne:String) {
        self.libelleJeu = nomJeu
        self.nombreJoueur = nombreJoueur
        self.ageMinimum = ageMinimum
        self.duree = duree
        self.prototype = prototype
        self.nomPersonne=nomPersonne
    }

}
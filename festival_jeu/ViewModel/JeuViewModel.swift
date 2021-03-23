//
// Created by etud on 23/03/2021.
//

import Foundation


class JeuViewModel:Identifiable{
    let id = UUID()
    private var jeu:Jeu
    private(set) var libelleJeu:String
    private(set) var nombreJoueur:Int
    private(set) var ageMinimum:Int
    private(set) var duree:String
    private(set) var prototype:Bool
    private(set) var nomPersonne:String

    init(jeu: Jeu) {
        self.jeu = jeu
        self.libelleJeu = jeu.libelleJeu
        self.nombreJoueur = jeu.nombreJoueur
        self.ageMinimum = jeu.ageMinimum
        self.duree = jeu.duree
        self.prototype = jeu.prototype
        self.nomPersonne=jeu.nomPersonne

    }
}
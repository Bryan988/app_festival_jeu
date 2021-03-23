//
// Created by etud on 23/03/2021.
//

import Foundation

class ListeJeuxIntent{
    @ObservedObject var listeJeux : GroupeJeuViewModel

    init(listeJeux: GroupeJeuViewModel) {
        self.listeJeux = listeJeux
    }
    func loaded(jeux : [Jeu]){
        self.listeJeux.loadingState = .initState
    }
    func loadJeux(url:String){
        self.listeJeux.loadingState = .loading("loading")
        // Get Data from link
        //valRetour=on prend les valeurs aec le lien
        //self.listeJeux.loadingState = .loaded(valretour)

        //.loaded
    }

}
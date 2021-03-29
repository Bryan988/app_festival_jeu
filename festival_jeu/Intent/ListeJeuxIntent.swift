//
// Created by etud on 23/03/2021.
//

import Foundation
import SwiftUI

class ListeJeuxIntent{
    @ObservedObject var listeJeux : GroupeJeuViewModel

    init(listeJeux: GroupeJeuViewModel) {
        self.listeJeux = listeJeux
    }
    /*func loaded(jeux : [Jeu]){

        self.listeJeux.loadingState = .initState
    }*/
    func loadJeux(){
        self.listeJeux.loadingState = .loading("loading")
        // Get Data from link
        JeuHelper.loadAllGames(endofrequest:JSONLoaded)

        //valRetour=on prend les valeurs aec le lien
        //self.listeJeux.loadingState = .loaded(valretour)

        //.loaded
    }
    func JSONLoaded(result: Result<[Jeu],HttpRequestError>) {
            switch result {
            case let .success(data):
                print("hi")
                self.listeJeux.loadingState = .loaded(data)
                break;
            case let .failure(error):
                print(error)
                break;
            }

    }
    func filterJeux(nomJeu:String){
        self.listeJeux.loadingState = .loadingFilter(nomJeu)
    }


    func refresh(){
        self.listeJeux.loadingState = .initState
    }

}
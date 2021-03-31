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

    func loadJeux(){
        self.listeJeux.loadingState = .loading("loading")
        // Get Data from link
        JeuHelper.loadAllGames(endofrequest:JSONLoaded)
    }

    func JSONLoaded(result: Result<[Jeu],HttpRequestError>) {
            switch result {
            case let .success(data):
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

    @objc func refresh(){
        self.listeJeux.loadingState = .initState
    }
}
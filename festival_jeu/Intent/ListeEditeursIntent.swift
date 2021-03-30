//
// Created by user190484 on 28/03/2021.
//

import Foundation
import SwiftUI

class ListeEditeursIntent {
    @ObservedObject var listeEditeurs : GroupeEditeurViewModel

    init(listeEditeurs: GroupeEditeurViewModel) {
        self.listeEditeurs = listeEditeurs
    }

    func loadEditeurs(){
        self.listeEditeurs.loadingStateEditeur = .loading("loading")
        // Get Data from link
        JeuHelper.loadAllEditors(endofrequest:JSONEDITEURLoaded)
    }

    func JSONEDITEURLoaded(result: Result<[Editeur],HttpRequestError>) {
        switch result {
        case let .success(data):
            print(data)
            self.listeEditeurs.loadingStateEditeur = .loaded(data)
            break;
        case let .failure(error):
            print(error)
            break;
        }

    }

    func filterEditeurs(nomEditeur:String){
        self.listeEditeurs.loadingStateEditeur = .loadingFilter(nomEditeur)
    }

    @objc func refresh(){
        self.listeEditeurs.loadingStateEditeur = .initState
    }
}
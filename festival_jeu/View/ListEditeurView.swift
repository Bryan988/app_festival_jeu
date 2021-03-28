//
// Created by user190484 on 28/03/2021.
//

import SwiftUI

struct ListeEditeurView: View {

    @ObservedObject var listeEditeurs : GroupeEditeurViewModel
    var intent : ListeEditeursIntent
    private var editeurState : LoadingStateEditeur{
        return self.listeEditeurs.loadingStateEditeur
    }

    init(listeEditeurs l:GroupeEditeurViewModel) {
        self.listeEditeurs  = l
        self.intent     = ListeEditeursIntent(listeEditeurs: l)
        let _  = self.listeEditeurs.$loadingStateEditeur.sink(receiveValue: stateChanged)
    }

    func stateChanged(state:LoadingStateEditeur){
        switch state {
        case .initState : self.intent.loadEditeurs()
        default:break
        }
    }

    init(listeEditeurs : GroupeEditeurViewModel,intent:ListeEditeursIntent){
        self.listeEditeurs = listeEditeurs
        self.intent=intent
    }

    func loadData(){
        self.intent.loadEditeurs()
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listeEditeurs.listeEditeurs) { editeur in
                        NavigationLink(
                                destination: DetailEditeurView(editeur: editeur)) {
                            HStack {
                                Text("\(editeur.nomPersonne) - \(editeur.games.count) Jeu"+(editeur.games.count > 1 ? "x" : ""))
                                Spacer()
                            }.foregroundColor(.blue)
                        }

                    }
                }.navigationBarTitle("Liste des éditeurs")
                ErrorViewEditeur(state: editeurState)
                Button("Refresh") {
                    intent.refresh()
                }
            }

        }
    }
}

struct ErrorViewEditeur : View{
    let state : LoadingStateEditeur
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading:
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
                Text("\(data.count) éditeurs présentes!")
            }
            Spacer()
        }
    }
}

struct ErrorMessageEditeur : View {
    let error: Error
    var body: some View {
        VStack {
            Text("Error in search request")
        }
    }
}
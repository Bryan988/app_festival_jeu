//
// Created by user190484 on 28/03/2021.
//

import SwiftUI
import SwiftUIRefresh

struct ListeEditeurView: View {

    @ObservedObject var listeEditeurs : GroupeEditeurViewModel
    @State private var isShowing = false
    @State var text: String = ""
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

    func filterData(nomEditeur: String) {
        self.intent.filterEditeurs(nomEditeur: nomEditeur)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    TextField("Rechercher ...", text: $text).onChange(of: text, perform: {newValue in
                                filterData(nomEditeur: text)
                            })
                            .padding(.top, 20).padding(.bottom, 10)
                    Image(systemName: "magnifyingglass").foregroundColor(.blue)
                    Spacer()
                }
                Divider()
                ErrorViewEditeur(state: editeurState)
                if(self.listeEditeurs.listeEditeurs.count == 0){
                    Text("Il n'y a pas actuellement d'éditeur à afficher").padding(.top, 10)
                }
                List {
                    ForEach(listeEditeurs.listeEditeurs) { editeur in
                        NavigationLink(
                                destination:ListeJeuxView(listejeux: GroupeJeuViewModel(groupeJeu: GroupeJeu(jeux: editeur.games)), nomZone:editeur.nomPersonne)
                        ) {
                            VStack {
                                Image(systemName: "person.crop.square.fill.and.at.rectangle")
                                        .resizable()
                                        .frame(width: 65, height: 50)
                                Text("\(editeur.nomPersonne) - \(editeur.games.count) Jeu"+(editeur.games.count > 1 ? "x" : ""))
                                        .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                }.navigationBarTitle("Liste des éditeurs")
                        .pullToRefresh(isShowing: $isShowing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                intent.refresh()
                                self.isShowing = false
                            }
                        }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Liste des éditeurs").font(.headline)
                        Image("logo180")
                                .resizable()
                                .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}

struct ErrorViewEditeur : View{
    let state : LoadingStateEditeur
    var body: some View{
        VStack{
            switch state{
            case .loading:
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
                Text(data.count > 1 ? "\(data.count) éditeurs présents" : "\(data.count) éditeur présent").italic()
                        .bold().foregroundColor(.blue).padding(.top, 10).padding(.bottom, 10)
            }
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
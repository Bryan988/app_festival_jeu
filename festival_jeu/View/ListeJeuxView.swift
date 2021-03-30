//
// Created by etud on 23/03/2021.
//

import SwiftUI
import SwiftUIRefresh

struct ListeJeuxView: View {
    @State private var isShowing = false
    @ObservedObject var listeJeux : GroupeJeuViewModel
    var intent : ListeJeuxIntent
    var nomZone : String = ""
    private var jeuState : LoadingState{
        return self.listeJeux.loadingState
    }
    init(listejeux:GroupeJeuViewModel,nomZone:String){
        self.listeJeux = listejeux
        self.intent = ListeJeuxIntent(listeJeux: listejeux)
        self.nomZone = nomZone
    }

    init() {
        print("nice")
        var GjVM : GroupeJeuViewModel =  GroupeJeuViewModel(groupeJeu: GroupeJeu())
        self.listeJeux  = GjVM
        self.intent     = ListeJeuxIntent(listeJeux: GjVM)
        let _  = self.listeJeux.$loadingState.sink(receiveValue: stateChanged)
    }
    func stateChanged(state:LoadingState){
        switch state {
        case .initState : self.intent.loadJeux()
        default:break
        }
    }

    func loadData(){
        self.intent.loadJeux()
    }
    func filterData(nomJeu:String){
        self.intent.filterJeux(nomJeu:nomJeu)
    }
    @State var text : String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                HStack{
                    Spacer()
                    TextField("Rechercher ...", text: $text).padding(.top, 10)
                    Button(action: {filterData(nomJeu: text)}){
                        Image(systemName: "magnifyingglass")
                    }
                    Spacer()
                }
                ErrorView(state: jeuState).padding(.top, 10)
                List(listeJeux.listeJeux) { game in
                        NavigationLink(
                                //change to destination of a game
                                destination: DetailJeuView(jeu: game)) {
                            HStack {
                                Text("\(game.libelleJeu)")
                                Spacer()
                            }.foregroundColor(.black)
                        }
                }.navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Text(nomZone=="" ? "Liste des jeux" : "Jeux \(nomZone)").font(.headline)
                                    Image("logo180")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                }
                            }
                        }
                .pullToRefresh(isShowing: $isShowing) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        intent.refresh()
                        self.isShowing = false
                    }
                }
                Spacer()
            }
        }
    }
}

struct ErrorView : View{
    let state : LoadingState
    var body: some View{
        VStack{
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
                Text(data.count > 1 ? "\(data.count) jeux présents" : "\(data.count) jeu présent")
            }
        }
    }
}

struct ErrorMessage : View{
    let error :  Error
    var body: some View{
        VStack{
            Text("Error in search request")
        }
    }
}

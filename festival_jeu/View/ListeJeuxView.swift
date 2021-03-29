//
// Created by etud on 23/03/2021.
//

import SwiftUI

struct ListeJeuxView: View {
    @ObservedObject var listeJeux : GroupeJeuViewModel
    var intent : ListeJeuxIntent
    private var jeuState : LoadingState{
        return self.listeJeux.loadingState
    }

    init(listeJeux l:GroupeJeuViewModel) {
        print("nice")
        self.listeJeux  = l
        self.intent     = ListeJeuxIntent(listeJeux: l)
        let _  = self.listeJeux.$loadingState.sink(receiveValue: stateChanged)

    }
    func stateChanged(state:LoadingState){
        switch state {
        case .initState : self.intent.loadJeux()
        default:break
        }
    }


    init(listeJeux : GroupeJeuViewModel,intent:ListeJeuxIntent){
        self.listeJeux = listeJeux
        self.intent=intent
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

                    VStack{
                        HStack{
                            Spacer()
                            TextField("search for ...", text: $text)
                            Button(action: {filterData(nomJeu: text)}){
                                Image(systemName: "magnifyingglass")
                            }
                            Spacer()

                        }
                        List(listeJeux.listeJeux) { game in

                            NavigationLink(
                                    //change to destination of a game
                                    destination: DetailJeuView(jeu: game)) {
                                HStack {
                                    Text("\(game.libelleJeu)").font(.system(size: 19, weight:.medium, design:.default))
                                    Spacer()
                                }.foregroundColor(.black)
                            }
                        }.navigationBarTitle("Liste des jeux")
                        Spacer()
                        ErrorView(state: jeuState)
                        Button("Refresh") {
                            intent.refresh()
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
                Text("\(data.count) Jeux présents!")
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
struct ListeJeuxView_Previews: PreviewProvider {
    static var previews: some View {
        ListeJeuxView(listeJeux: GroupeJeuViewModel(groupeJeu: GroupeJeu(jeux: [Jeu(nomJeu: "TEST", nombreJoueur: "4", ageMinimum: 2, duree:"30m", prototype: true, nomPersonne: "José")])))
    }
}
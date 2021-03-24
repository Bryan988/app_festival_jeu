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

    var body: some View {
        VStack{
            List{
                ForEach(listeJeux.listeJeux){ game in
                    HStack{
                        Text("\(game.libelleJeu)")
                        Spacer()
                    }.foregroundColor(.red)
                }
            }
            ErrorView(state: jeuState)
        }
    }
}


struct ErrorView : View{
    let state : LoadingState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading, .loaded:
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
                Text("\(data.count) tracks found!")
            }
            Spacer()
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
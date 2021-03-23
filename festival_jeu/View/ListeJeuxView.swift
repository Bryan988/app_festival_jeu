//
// Created by etud on 23/03/2021.
//

import SwiftUI

struct ListeJeuxView: View {
    @ObservedObject var listeJeux : GroupeJeuViewModel
    var intent : ListeJeuxIntent
    var body: some View {

        Text("Hello, world!")
                .padding()
    }
    init(listeJeux : GroupeJeuViewModel,intent:ListeJeuxIntent){
        self.listeJeux=listeJeux
        self.intent=intent
    }
}

struct ListeJeuxView_Preview: PreviewProvider {
    static var previews: some View {
        ListeJeuxView(listeJeux: GroupeJeuViewModel(groupeJeu: GroupeJeu()), intent: <#T##ListeJeuxIntent##festival_jeu.ListeJeuxIntent#>)
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
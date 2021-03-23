//
// Created by etud on 23/03/2021.
//

import SwiftUI

struct ListeJeuxView: View {
    @ObservedObject var listeJeux : GroupeJeuViewModel
    var intent : ListeJeuxIntent

    init() {
        let groupJeuVMinit = GroupeJeuViewModel(groupeJeu: GroupeJeu())
        listeJeux = groupJeuVMinit
        intent = ListeJeuxIntent(listeJeux: groupJeuVMinit)
        print("hello")
        let jeuHelper = JeuHelper()
        jeuHelper.loadAllGames() { result in
            switch result {
            case let .success(data):
                print(data)
                break;
            case let .failure(error):
                print(error)
                break;
            }
        }
    }

    init(listeJeux : GroupeJeuViewModel,intent:ListeJeuxIntent){
        self.listeJeux=listeJeux
        self.intent=intent
    }

    var body: some View {
        Text("Hello, world!")
                .padding()
    }
}

struct ListeJeuxView_Preview: PreviewProvider {
    static var previews: some View {
        ListeJeuxView(listeJeux: GroupeJeuViewModel(groupeJeu: GroupeJeu()),
                intent: ListeJeuxIntent(listeJeux: GroupeJeuViewModel(groupeJeu: GroupeJeu())))
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
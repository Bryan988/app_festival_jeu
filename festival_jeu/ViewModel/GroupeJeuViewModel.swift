//
// Created by etud on 23/03/2021.
//

import Foundation

enum LoadingState{
    case initState
    case loading(String)
    case loaded([Jeu])
    case loadingError(Error)
}
class GroupeJeuViewModel:Identifiable,ObservableObject{
    let id=UUID()
    private(set) var groupeJeu : GroupeJeu
    private(set) var listeJeux : [JeuViewModel]
    @Published var loadingState : LoadingState = .initState {
        didSet {
            switch self.loadingState{
            case let .loaded(data):
                self.groupeJeu.new(jeux:data)

            case .loadingError:
                return
            default:
                return
            }
        }
    }

    init(groupeJeu:GroupeJeu) {
        self.groupeJeu=groupeJeu
        self.listeJeux=[]
        for g in groupeJeu.jeux{
            self.listeJeux.append(JeuViewModel(jeu: g))
        }
    }

    func getJeux()->[JeuViewModel]{
        return self.listeJeux
    }
}
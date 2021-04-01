//
// Created by etud on 23/03/2021.
//

import Foundation

enum LoadingState{
    case initState
    case loading(String)
    case loaded([Jeu])
    case loadingError(Error)
    case loadingFilter(String)
}
class GroupeJeuViewModel:Identifiable,ObservableObject{
    let id=UUID()
    private(set) var groupeJeu : GroupeJeu
    private(set) var listeJeux : [JeuViewModel]
    @Published var loadingState : LoadingState = .initState {
        didSet {
            switch self.loadingState{
            case let.loading(msg):
                print(msg)
            case let .loaded(data):
                self.groupeJeu.new(jeux:data)
                for g in data{
                    self.listeJeux.append(JeuViewModel(jeu: g))
                }
            case .loadingError:
                print("error")
            case let.loadingFilter(nomJeu):
                reInitJeux()
                if(nomJeu != ""){
                    let shortNames = self.listeJeux.filter { ($0.libelleJeu.lowercased()).contains(nomJeu.lowercased()) }
                    self.listeJeux=shortNames
                }
            case .initState :
                self.listeJeux.removeAll()

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

    func reInitJeux(){
        self.listeJeux=[]
        for g in groupeJeu.jeux{
            self.listeJeux.append(JeuViewModel(jeu: g))
        }
    }

    func getJeux()->[JeuViewModel]{
        return self.listeJeux
    }

}
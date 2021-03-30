//
// Created by user190484 on 28/03/2021.
//

import Foundation

enum LoadingStateEditeur{
    case initState
    case loading(String)
    case loaded([Editeur])
    case loadingError(Error)
    case loadingFilter(String)
}

class GroupeEditeurViewModel:Identifiable,ObservableObject{
    let id=UUID()
    private(set) var groupeEditeur : GroupeEditeur
    private(set) var listeEditeurs : [EditeurViewModel]
    @Published var loadingStateEditeur : LoadingStateEditeur = .initState {
        didSet {
            switch self.loadingStateEditeur{
            case let.loading(msg):
                print(msg)
            case let .loaded(data):
                self.groupeEditeur.new(editeurs:data)
                for editor in data{
                    self.listeEditeurs.append(EditeurViewModel(editeur: editor))
                }
                print(self.listeEditeurs)
            case .loadingError:
                print("error")
            case let.loadingFilter(nomEditeur):
                reInitEditeurs()
                if(nomEditeur != ""){
                    let shortNames = self.listeEditeurs.filter { $0.nomPersonne.contains(nomEditeur) }
                    self.listeEditeurs=shortNames
                }
            case .initState :
                self.listeEditeurs.removeAll()
            default:
                return
            }
        }
    }

    init(groupeEditeur:GroupeEditeur) {
        self.groupeEditeur=groupeEditeur
        self.listeEditeurs=[]
        for editor in groupeEditeur.editeurs{
            self.listeEditeurs.append(EditeurViewModel(editeur: editor))
        }
    }

    func reInitEditeurs(){
        self.listeEditeurs=[]
        for editor in groupeEditeur.editeurs{
            self.listeEditeurs.append(EditeurViewModel(editeur: editor))
        }
    }

    func getEditeurs()->[EditeurViewModel]{
        return self.listeEditeurs
    }
}


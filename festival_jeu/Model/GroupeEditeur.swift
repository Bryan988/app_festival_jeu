//
// Created by user190484 on 28/03/2021.
//

import Foundation

class GroupeEditeur{
    private(set) var editeurs : [Editeur]

    init(editeurs: [Editeur]) {
        self.editeurs = editeurs
    }

    init(){
        self.editeurs=[]
    }

    func new(editeurs:[Editeur]){
        self.editeurs=editeurs
    }
}
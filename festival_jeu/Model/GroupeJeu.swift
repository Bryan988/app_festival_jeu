//
// Created by etud on 23/03/2021.
//

import Foundation

class GroupeJeu{
    private(set) var jeux : [Jeu]

    init(jeux: [Jeu]) {
        self.jeux = jeux
    }
    init(){
        self.jeux=[]
    }
    func new(jeux:[Jeu]){
        self.jeux=jeux
    }
}
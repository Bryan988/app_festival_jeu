//
// Created by user187674 on 25/03/2021.
//

import Foundation
class Zone {
    private(set) var libelleZone:String
    private(set) var games:[Jeu]


    init(libelleZone: String, games: [Jeu]) {
        self.libelleZone = libelleZone
        self.games = games
    }

}
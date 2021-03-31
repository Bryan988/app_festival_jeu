//
// Created by etud on 23/03/2021.
//

import Foundation

class ZoneViewModel:Identifiable{
    let id = UUID()
    private var zone:Zone
    private(set) var libelleZone:String
    private(set) var games:[Jeu]

    init(zone: Zone) {
        self.zone=zone
        self.libelleZone = zone.libelleZone
        self.games = zone.games
    }
}
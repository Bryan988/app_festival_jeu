//
// Created by etud on 23/03/2021.
//

import Foundation
import SwiftUI

class ListeZonesIntent{
    @ObservedObject var listeZones : GroupeZoneViewModel

    init(listeZones: GroupeZoneViewModel) {
        self.listeZones = listeZones
    }

    func loadZones(){
        self.listeZones.loadingStateZone = .loading("loading")
        // Get Data from link

        JeuHelper.loadAllZones(endofrequest:JSONZONELoaded)

    }

    func JSONZONELoaded(result: Result<[Zone],HttpRequestError>) {
        switch result {
        case let .success(data):
            self.listeZones.loadingStateZone = .loaded(data)
            break;
        case let .failure(error):
            print(error)
            break;
        }
    }

    func filterZones(nomZone:String){
        self.listeZones.loadingStateZone = .loadingFilter(nomZone)
    }

    func refresh(){
        self.listeZones.loadingStateZone = .initState
    }
}
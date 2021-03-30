//
// Created by user187674 on 27/03/2021.
//

import Foundation
import SwiftUI

struct DetailZoneView: View{
    var zone : ZoneViewModel
    var listeJeux : GroupeJeuViewModel

    init(zone : ZoneViewModel){
        self.zone = zone
        self.listeJeux = GroupeJeuViewModel(groupeJeu: GroupeJeu(jeux: zone.games))
    }

    var body: some View{
            NavigationView{
                VStack
                {
                    List {
                        Text("Liste des jeux :")
                        ForEach(zone.games) { game in
                            NavigationLink(
                                    //change to destination of a game
                                    destination: DetailJeuView(jeu: JeuViewModel(jeu: game))) {
                                HStack {
                                    Text("\(game.libelleJeu)")
                                    Spacer()
                                }.foregroundColor(.blue)
                            }
                        }
                    }
                }
                navigationTitle("Zone "+"\(zone.libelleZone)")
            }
    }
}
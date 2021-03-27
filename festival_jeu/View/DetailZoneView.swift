//
// Created by user187674 on 27/03/2021.
//

import Foundation
import SwiftUI

struct DetailZoneView: View{
    var zone : ZoneViewModel
    init(zone : ZoneViewModel)
    {
        self.zone = zone
    }
    var body: some View{

            NavigationView{
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/)
                {
                    List {
                        Text("Liste des jeux :")
                        ForEach(zone.games) { game in

                            NavigationLink(
                                    //change to destination of a game
                                    destination: DetailZoneView(zone: zone)) {
                                HStack {
                                    Text("\(game.libelleJeu)")
                                    Spacer()
                                }.foregroundColor(.blue)
                            }

                        }
                    }





                }

                        .navigationTitle("Zone "+"\(zone.libelleZone)")

            }

    }
}
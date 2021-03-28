//
// Created by user190484 on 28/03/2021.
//

import Foundation
import SwiftUI

struct DetailEditeurView: View{
    var editeur : EditeurViewModel
    init(editeur : EditeurViewModel)
    {
        self.editeur = editeur
    }
    var body: some View{

        NavigationView{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/)
            {
                List {
                    Text("Liste des jeux :")
                    ForEach(editeur.games) { game in
                        NavigationLink(
                                //change to destination of a game
                                destination: DetailEditeurView(editeur: editeur)) {
                            HStack {
                                Text("\(game.libelleJeu)")
                                Spacer()
                            }.foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Editeur "+"\(editeur.nomPersonne)")
        }
    }
}
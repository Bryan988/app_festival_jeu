//
// Created by user190484 on 28/03/2021.
//

import Foundation
import SwiftUI

struct DetailJeuView: View{
    var jeu : JeuViewModel
    private var prototype : String

    init(jeu : JeuViewModel){
        self.jeu = jeu
        self.prototype = (jeu.prototype ? "Oui" : "Non")
    }

    var body: some View{
        VStack{
            Image("logo180")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width : 150,height:150)
                .clipped()
                .background(Color.gray)
                .cornerRadius(150)
                .shadow(radius:3)
            Text("\(jeu.libelleJeu)").font(.title)
            Form{
                HStack{
                    Image(systemName: "person.fill").resizable().frame(width: 24,height: 24)
                    Text("Editeur")
                    Spacer()
                    Text("\(jeu.nomPersonne)").foregroundColor(.gray).font(.callout)
                }
                HStack{
                    Image(systemName: "person.3.fill").resizable().frame(width: 25,height: 15)
                    Text("Nombre de joueurs")
                    Spacer()
                    Text("\(jeu.nombreJoueur)").foregroundColor(.gray).font(.callout)
                }
                HStack{
                    Image(systemName: "calendar.badge.exclamationmark").resizable().frame(width: 24,height: 24)
                    Text("Age minimum")
                    Spacer()
                    Text("\(jeu.ageMinimum) ans").foregroundColor(.gray).font(.callout)
                }
                HStack{
                    Image(systemName: "clock").resizable().frame(width: 24,height: 24)
                    Text("Durée")
                    Spacer()
                    Text("\(jeu.duree)").foregroundColor(.gray).font(.callout)
                }
                HStack{
                    Image(systemName: "hammer.fill").resizable().frame(width: 24,height: 24)
                    Text("Prototype")
                    Spacer()
                    Text(" \(prototype)").foregroundColor(.gray).font(.callout)
                }
            }
        }
    }
}
//
//  ContentView.swift
//  festival_jeu
//
//  Created by user190484 on 11/03/2021.
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var JeuVM : GroupeJeuViewModel = GroupeJeuViewModel(groupeJeu: GroupeJeu())
    @State private var tabSelected = 1



    var body: some View {

        TabView(selection: $tabSelected){
            ListeZoneView()
                    .tabItem {Label("Zone",systemImage : "list.dash")}.tag(0)

            ListeJeuxView(listeJeux: JeuVM)
            .tabItem {Label("Jeux",systemImage : "list.dash")}.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

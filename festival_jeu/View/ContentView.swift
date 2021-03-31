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
    @StateObject var ZoneVM : GroupeZoneViewModel = GroupeZoneViewModel(groupeZone: GroupeZone())
    @StateObject var EditeurVM : GroupeEditeurViewModel = GroupeEditeurViewModel(groupeEditeur: GroupeEditeur())
    @State private var tabSelected = 1

    var body: some View {
        TabView(selection: $tabSelected){
            ListeZoneView(listeZones: ZoneVM)
                    .tabItem {Label("Zones",systemImage : "mappin.and.ellipse")}.tag(0)
            ListeJeuxView(listeJeux: JeuVM)
            .tabItem {Label("Jeux",systemImage : "gamecontroller")}.tag(1)
            ListeEditeurView(listeEditeurs : EditeurVM)
            .tabItem {Label("Editeurs", systemImage : "person")}.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

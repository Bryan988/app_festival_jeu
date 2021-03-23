//
//  ContentView.swift
//  festival_jeu
//
//  Created by user190484 on 11/03/2021.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Button("Zones"){ print("Tapped") }
                Button("Editeurs"){ print("Tapped") }
                NavigationLink(destination: ListeJeuxView()){
                    Text("Jeux")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

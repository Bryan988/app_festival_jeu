//
// Created by etud on 23/03/2021.
//

import SwiftUI
import SwiftUIRefresh

struct ListeZoneView: View {
    @ObservedObject var listeZones: GroupeZoneViewModel
    @State private var isShowing = false
    var intent: ListeZonesIntent
    @State var text: String = ""
    private var zoneState: LoadingStateZone {
        return self.listeZones.loadingStateZone
    }

    init(listeZones l: GroupeZoneViewModel) {
        print("nice")
        self.listeZones = l
        self.intent = ListeZonesIntent(listeZones: l)
        let _ = self.listeZones.$loadingStateZone.sink(receiveValue: stateChanged)
    }

    func stateChanged(state: LoadingStateZone) {
        switch state {
        case .initState: self.intent.loadZones()
        default:break
        }
    }

    init(listeZones: GroupeZoneViewModel, intent: ListeZonesIntent) {
        self.listeZones = listeZones
        self.intent = intent
    }

    func loadData() {
        self.intent.loadZones()
    }

    func filterData(nomZone: String) {
        self.intent.filterZones(nomZone: nomZone)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    TextField("Rechercher ...", text: $text).padding(.top, 10)
                    Button(action: {filterData(nomZone: text)}){
                        Image(systemName: "magnifyingglass")
                    }
                    Spacer()
                }
                HStack {
                    ErrorViewZone(state: zoneState).padding(.top, 10)
                }
                List {
                    ForEach(listeZones.listeZones) { zone in
                        NavigationLink(
                                destination: ListeJeuxView(listejeux: GroupeJeuViewModel(groupeJeu: GroupeJeu(jeux: zone.games)),nomZone:zone.libelleZone)
                        ) {
                            VStack{
                                Image("zone")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                Text("\(zone.libelleZone) - \(zone.games.count) Jeu" + (zone.games.count > 1 ? "x" : ""))
                                        .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                }
                        .pullToRefresh(isShowing: $isShowing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                intent.refresh()
                                self.isShowing = false
                            }
                        }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Liste des zones").font(.headline)
                        Image("logo180")
                                .resizable()
                                .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}


struct ErrorViewZone: View {
    let state: LoadingStateZone
    var body: some View {
        VStack {
            switch state {
            case .loading:
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state {
                Text("\(data.count) zones présentes")
            }
        }
    }
}

struct ErrorMessageZone: View {
    let error: Error
    var body: some View {
        VStack {
            Text("Error in search request")
        }
    }
}

//
// Created by etud on 23/03/2021.
//

import SwiftUI

struct ListeZoneView: View {
    @ObservedObject var listeZones : GroupeZoneViewModel
    var intent : ListeZonesIntent
    private var zoneState : LoadingStateZone{
        return self.listeZones.loadingStateZone
    }




    init(listeZones l:GroupeZoneViewModel) {
        print("nice")
        self.listeZones  = l
        self.intent     = ListeZonesIntent(listeZones: l)
        let _  = self.listeZones.$loadingStateZone.sink(receiveValue: stateChanged)


    }
    func stateChanged(state:LoadingStateZone){
        switch state {
        case .initState : self.intent.loadZones()
        default:break
        }
    }


    init(listeZones : GroupeZoneViewModel,intent:ListeZonesIntent){
        self.listeZones = listeZones
        self.intent=intent
    }
    func loadData(){
        self.intent.loadZones()
    }




    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listeZones.listeZones) { zone in
                        NavigationLink(
                                destination: DetailZoneView(zone: zone)) {
                            HStack {
                                Text("\(zone.libelleZone)")
                                Spacer()
                            }.foregroundColor(.blue)
                        }

                    }
                }.navigationBarTitle("Liste des zones")
                ErrorViewZone(state: zoneState)
                Button("Refresh") {
                    intent.refresh()
                }
            }

        }
    }
}


struct ErrorViewZone : View{
    let state : LoadingStateZone
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading:
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
                Text("\(data.count) Zones présentes!")
            }
            Spacer()
        }
    }
}
struct ErrorMessageZone : View{
    let error :  Error
    var body: some View{
        VStack{
            Text("Error in search request")
        }
    }
}
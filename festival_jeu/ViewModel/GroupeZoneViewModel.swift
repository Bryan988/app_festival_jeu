//
// Created by etud on 23/03/2021.
//

import Foundation

enum LoadingStateZone{
    case initState
    case loading(String)
    case loaded([Zone])
    case loadingError(Error)
}
class GroupeZoneViewModel:Identifiable,ObservableObject{
    let id=UUID()
    private(set) var groupeZone : GroupeZone
    private(set) var listeZones : [ZoneViewModel]
    @Published var loadingStateZone : LoadingStateZone = .initState {
        didSet {
            switch self.loadingStateZone{
            case let.loading(msg):
                print(msg)
            case let .loaded(data):
                self.groupeZone.new(zones:data)
                for g in data{
                    self.listeZones.append(ZoneViewModel(zone: g))
                }
                print(self.listeZones)

            case .loadingError:
                print("error")
            case .initState :
                self.listeZones.removeAll()

            default:
                return
            }
        }
    }

    init(groupeZone:GroupeZone) {
        self.groupeZone=groupeZone
        self.listeZones=[]
        for g in groupeZone.zones{
            self.listeZones.append(ZoneViewModel(zone: g))
        }
    }

    func getZones()->[ZoneViewModel]{
        return self.listeZones
    }

}
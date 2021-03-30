//
// Created by etud on 23/03/2021.
//

import Foundation

enum LoadingStateZone{
    case initState
    case loading(String)
    case loaded([Zone])
    case loadingError(Error)
    case loadingFilter(String)
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
            case let.loadingFilter(libelleZone):
                reInitZones()
                if(libelleZone != ""){
                    let shortNames = self.listeZones.filter { $0.libelleZone.contains(libelleZone) }
                    print(shortNames)
                    self.listeZones=shortNames
                }
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

    func reInitZones(){
        self.listeZones=[]
        for z in groupeZone.zones{
            self.listeZones.append(ZoneViewModel(zone: z))
        }
    }

    func getZones()->[ZoneViewModel]{
        return self.listeZones
    }
}
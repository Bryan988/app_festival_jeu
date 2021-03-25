//
// Created by etud on 23/03/2021.
//

import Foundation

class GroupeZone{
    private(set) var zones : [Zone]

    init(zones: [Zone]) {
        self.zones = zones
        print(self.zones)
    }
    init(){
        self.zones=[]
    }
    func new(zones:[Zone]){
        self.zones=zones
    }
}
//
// Created by user190484 on 23/03/2021.
//

import Foundation

struct GameData : Decodable {
    var libelleJeu:String?
    var nombreJoueur:Int?
    var ageMinimum:Int?
    var duree:String?
    var prototype:Bool?
    var nomPersonne:String?
}

// The data of a zone
struct ZoneData : Decodable {

}

// The data of an editor
struct Editeur : Decodable {

}


struct JeuHelper{


    static func loadAllGames(fromFile filename: String) -> Result<[GameData],HttpRequestError>{
        let getDataHelper = GetDataHelper()
        getDataHelper.httpGetJsonData(from: "http://localhost:8080/api/games/") {
            (result: Result<[GameData], HttpRequestError>) in
            switch result{
            case let .success(data):
                guard let games = self.trackData2Track(data: data) else { return .failure(.JsonDecodingFailed) }
                return .success(games)
            case let .failure(error):
                return .failure(error)
            }
        }
    }

    func
}
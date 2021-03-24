//
// Created by user190484 on 23/03/2021.
//

import Foundation

struct GameData : Codable {
    var libelleJeu:String
    var nombreJoueur:String
    var ageMinimum:Int
    var duree:String
    var prototype:Bool
    var nomPersonne:String
}

// The data of a zone
struct ZoneData : Codable {

}

// The data of an editor
struct Editeur : Codable {

}


struct JeuHelper{

    // Translate a list of gamesData into a list of games
    static func gameData2game(data: [GameData]) -> [Jeu]?{
        var games = [Jeu]()
        for game in data{
            let newGame = Jeu(nomJeu: game.libelleJeu,nombreJoueur: game.nombreJoueur, ageMinimum: game.ageMinimum,
                    duree: game.duree,prototype: game.prototype, nomPersonne: game.nomPersonne)
            games.append(newGame)
        }
        return games
    }

    // Translate a list of games into a list of games data
    static func game2GameData(data: [Jeu]) -> [GameData]{
        var gamesData = [GameData]()
        for game in data{
            let gameData = GameData(libelleJeu: game.libelleJeu,nombreJoueur: game.nombreJoueur, ageMinimum: game.ageMinimum,
                    duree: game.duree,prototype: game.prototype, nomPersonne: game.nomPersonne)
            gamesData.append(gameData)
        }
        return gamesData
    }

    // We ask the server to retrieve all the games
    static func loadAllGames(endofrequest: @escaping (Result<[Jeu],HttpRequestError>) -> Void){
        let getDataHelper = GetDataHelper()
        getDataHelper.httpGetJsonData(from: "https://festival-jeu-montpellier.herokuapp.com/api/games/") {
            (result: Result<[GameData], HttpRequestError>) in
            switch result{
            case let .success(data):
                guard let games = JeuHelper.gameData2game(data: data) else {
                    endofrequest(.failure(.JsonDecodingFailed))
                    return
                }
                endofrequest(.success(games))
                return
            case let .failure(error):
                endofrequest(.failure(error))
                return
            }
        }
    }
}
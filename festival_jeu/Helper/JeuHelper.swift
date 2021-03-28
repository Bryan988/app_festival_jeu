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

//data for zone
struct ZoneData : Codable {
    var libelleZone:String
    var games:[GameData]
}

// The data of an editor
struct EditeurData : Codable {
    var nomPersonne:String
    var games:[GameData]
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

    // Translate a list of ZoneData into a list of Zones
    static func zoneData2zone(data: [ZoneData]) -> [Zone]?{
        var zones = [Zone]()
        var games = [Jeu]()

        for zone in data{
            for game in zone.games{
                let gameData = Jeu(nomJeu: game.libelleJeu,nombreJoueur: game.nombreJoueur, ageMinimum: game.ageMinimum,
                        duree: game.duree,prototype: game.prototype, nomPersonne: game.nomPersonne)
                games.append(gameData)
            }

            let newZone = Zone(libelleZone: zone.libelleZone,games: games)
            zones.append(newZone)
        }
        return zones
    }

    // We ask the server to retrieve all the zones
    static func loadAllZones(endofrequest: @escaping (Result<[Zone],HttpRequestError>) -> Void){
        let getDataHelper = GetDataHelper()
        getDataHelper.httpGetJsonData(from: "https://festival-jeu-montpellier.herokuapp.com/api/gestion/zone/") {
            (result: Result<[ZoneData], HttpRequestError>) in
            switch result{
            case let .success(data):

                guard let zones = JeuHelper.zoneData2zone(data: data) else {
                    endofrequest(.failure(.JsonDecodingFailed))
                    return
                }
                endofrequest(.success(zones))
                return
            case let .failure(error):
                endofrequest(.failure(error))
                return
            }
        }
    }

    // Translate a list of EditeurData into a list of Editeur
    static func editeurData2editeur(data: [EditeurData]) -> [Editeur]?{
        var editeurs = [Editeur]()
        var games = [Jeu]()

        for editeur in data{
            for game in editeur.games{
                let gameData = Jeu(nomJeu: game.libelleJeu,nombreJoueur: game.nombreJoueur, ageMinimum: game.ageMinimum,
                        duree: game.duree,prototype: game.prototype, nomPersonne: editeur.nomPersonne)
                games.append(gameData)
                print(gameData)
            }
            let newEditeur = Editeur(nomPersonne: editeur.nomPersonne,games: games)
            editeurs.append(newEditeur)
        }
        return editeurs
    }

    // We ask the server to retrieve all the zones
    static func loadAllEditors(endofrequest: @escaping (Result<[Editeur],HttpRequestError>) -> Void){
        let getDataHelper = GetDataHelper()
        getDataHelper.httpGetJsonData(from: "https://festival-jeu-montpellier.herokuapp.com/api/gestion/jeuPresent/editeur") {
            (result: Result<[EditeurData], HttpRequestError>) in
            switch result{
            case let .success(data):

                guard let editeurs = JeuHelper.editeurData2editeur(data: data) else {
                    endofrequest(.failure(.JsonDecodingFailed))
                    return
                }
                endofrequest(.success(editeurs))
                return
            case let .failure(error):
                endofrequest(.failure(error))
                return
            }
        }
    }
}
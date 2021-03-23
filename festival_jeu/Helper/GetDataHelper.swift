//
// Created by user190484 on 23/03/2021.
//

import Foundation

// Contains the result of the request and the error, if any
enum Result<T, HttpRequestError> {
    case success(T)
    case failure(HttpRequestError)
}

enum HttpRequestError : Error, CustomStringConvertible{
    case fileNotFound(String)
    case badURL(String)
    case failingURL(URLError)
    case requestFailed
    case outputFailed
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknown

    var description : String {
        switch self {
        case .badURL(let url): return "Bad URL : \(url)"
        case .failingURL(let error): return "URL error : \(error.failureURLString ?? "")\n \(error.localizedDescription)"
        case .requestFailed: return "Request Failed"
        case .outputFailed: return "Output data Failed"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case .JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknown: return "unknown error"
        case .fileNotFound(let filename): return "File \(filename) not found"
        }
    }
}

// This class contains the functions used to
class GetDataHelper {

    func getJsonData<T: Decodable>(from url: URL, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void){
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    guard let decodedResponse = decodedData else {
                        endofrequest(.failure(.JsonDecodingFailed))
                        return
                    }
                    endofrequest(.success(decodedResponse))
                }
            }
            else{
                DispatchQueue.main.async {
                    if let error = error {
                        guard let error = error as? URLError else {
                            endofrequest(.failure(.unknown))
                            return
                        }
                        endofrequest(.failure(.failingURL(error)))
                    }
                    else{
                        guard let response = response as? HTTPURLResponse else{
                            endofrequest(.failure(.unknown))
                            return
                        }
                        guard response.statusCode == 200 else {
                            endofrequest(.failure(.requestFailed))
                            return
                        }
                        endofrequest(.failure(.unknown))
                    }
                }
            }
        }.resume()
    }

    func httpGetJsonData<T: Decodable>(from surl: String, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void){
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        getJsonData(from: url, endofrequest: endofrequest)
    }
}
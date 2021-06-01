//
//  ItunesNetworkService.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import Foundation

typealias GetItunesTracks = Result<ItunesResponse, NetworkServiceError>

protocol ItunesNetworkServiceProtocol {
    func getTracks(completion: @escaping (GetItunesTracks) -> Void)
    func loadImage(fromUrl: String, completion: @escaping (Data?) -> Void)
}

final class ItunesNetworkService {
    
    private let session: URLSession = .shared
}

extension ItunesNetworkService: ItunesNetworkServiceProtocol {

    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    func getTracks(completion: @escaping (GetItunesTracks) -> Void) {
//         Будет проходить поиск треков по запросу "Usher", в дальнейшем можно расширить функционал
        guard let url = URL(string: "https://itunes.apple.com/search?term=Usher&limit=10") else {
            completion(.failure(.unknown)); return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let completion: Completion = { rawData, response, taskError in
            
            do {
                let data = try self.dataResponse(data: rawData, response: response)
                let recievedData = try JSONDecoder().decode(ItunesResponse.self, from: data)
                completion(.success(recievedData))
            } catch let error as NetworkServiceError {
                completion(.failure(error))
            } catch {
                completion(.failure(.unknown))
            }
        }
        
        session.dataTask(with: request, completionHandler: completion).resume()
    }
    
    func loadImage(fromUrl: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: fromUrl) else {
            completion(nil); return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let completion: Completion = { data, response, error in
            do {
                let recievedData = try self.dataResponse(data: data, response: response)
                completion(recievedData)
            } catch {
                completion(nil)
            }
        }
        
        session.dataTask(with: request, completionHandler: completion).resume()
    }
    
    private func dataResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let dataResponse = response as? HTTPURLResponse, (200..<300).contains(dataResponse.statusCode),
              let data = data else {
            throw NetworkServiceError.unknown
        }
        return data
    }
}

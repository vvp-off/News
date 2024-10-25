//
//  HTTPClient.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 25.10.2024.
//

import Foundation

final class HTTPClient {
    
    // MARK: - Properties
    // можно добавить ключи в массив будет переберать если один умрет
    private var apiKeys = [
        "952c0e9330a946688f8c004d576640bd",
        "another_api_key"
    ]
    
    private let baseURL = "https://newsapi.org/v2/"
    private let sessions: URLSession
    
    init(with configuraiton: URLSessionConfiguration) {
        sessions = URLSession(configuration: configuraiton)
    }
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // MARK: - Methods
    
    func requestData(for service: ApiService) async throws -> [Article] {
        for apiKey in apiKeys {
            do {
                let urlString = baseURL + service.path + "&apiKey=\(apiKey)"
                guard let url = URL(string: urlString ) else {
                    throw RequestError.badURL
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTP.Method.get.rawValue
                
                debugPrint(urlRequest)
                let (data, response) = try await sessions.data(for: urlRequest)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        let loadData = try decoder.decode(NewsResponseModel.self, from: data)
                        return loadData.articles
                    case 401:
                        throw RequestError.apiKeyInvalid
                    case 403:
                        throw RequestError.apiKeyDisabled
                    case 429:
                        throw RequestError.rateLimited
                    case 400:
                        throw RequestError.parameterInvalid
                    default:
                        throw RequestError.unexpectedError
                    }
                }
            }
            catch  {
                print("Произошла ошибка: \(error.localizedDescription )")
            }
        }
        throw RequestError.apiKeyExhausted
    }
}

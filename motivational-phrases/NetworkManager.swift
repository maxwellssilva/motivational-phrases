//
//  NetworkManager.swift
//  motivational-phrases
//
//  Created by Maxwell Silva on 04/07/25.
//

import UIKit

// MARK: - APIError
enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
    case customError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "A URL fornecida é inválida."
        case .noData:
            return "Nenhum dado foi recebido da API."
        case .decodingError(let error):
            return "Falha ao decodificar os dados: \(error.localizedDescription)"
        case .networkError(let error):
            return "Erro de rede: \(error.localizedDescription)"
        case .customError(let message):
            return message
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}

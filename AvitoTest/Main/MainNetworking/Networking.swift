//
//  Networking.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 08.09.2021.
//

import Foundation

protocol NetworkingProtocol {
    func getCompany(urlString: String, completion: @escaping (Result<CompanyModel, Error>) -> ())
}

class Networking: NetworkingProtocol {
    func getCompany(urlString: String, completion: @escaping (Result<CompanyModel, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let company = try JSONDecoder().decode(CompanyModel.self, from: data)
                completion(.success(company))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

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
    
    private lazy var cache: NSCache = NSCache<NSString, CompanyModel>()
    
    func getCompany(urlString: String, completion: @escaping (Result<CompanyModel, Error>) -> ()) {
        
        if let cachedCompanyModel = cache.object(forKey: "Company" as NSString) {
            completion(.success(cachedCompanyModel))
        } else {
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            request.setValue("max-age=3600", forHTTPHeaderField: "Cache-Control")
            URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else { return }
                do {
                    guard let self = self else { return }
                    let company = try JSONDecoder().decode(CompanyModel.self, from: data)
                    self.cache.setObject(company, forKey: "Company")
                    completion(.success(company))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
        
        
    }
}

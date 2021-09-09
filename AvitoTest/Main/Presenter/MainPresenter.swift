//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 08.09.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}
protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, networkService: NetworkingProtocol, router: RoutingProtocol)
    func getCompany()
    //func appendToCache(cell: CompanyCell)
    var companyModel: CompanyModel? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    var companyModel: CompanyModel?
    var view: MainViewProtocol?
    var networkService: NetworkingProtocol?
    var router: RoutingProtocol?
    
    required init(view: MainViewProtocol, networkService: NetworkingProtocol, router: RoutingProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getCompany()
    }
    
    func getCompany() {
        networkService?.getCompany(urlString: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
        { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let companyModel):
                    let sortedEmployees = companyModel.company?.employees?.sorted(by: {$0.name! < $1.name!})
                    companyModel.company?.employees = sortedEmployees
                    self.companyModel = companyModel
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}


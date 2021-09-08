//
//  Builder.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 08.09.2021.
//

import UIKit

protocol BuildProtocol {
    func buildMain(router: RoutingProtocol) -> UIViewController
}


class Builder: BuildProtocol {
    func buildMain(router: RoutingProtocol) -> UIViewController {
        let networkService = Networking()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}

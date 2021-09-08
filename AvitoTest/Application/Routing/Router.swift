//
//  Router.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 08.09.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuildProtocol? { get set }
}

protocol RoutingProtocol: RouterMain {
    func initialViewController()
}

class Router: RoutingProtocol {
    var navigationController: UINavigationController?
    
    var builder: BuildProtocol?
    
    init(navVC: UINavigationController, builder: BuildProtocol) {
        self.navigationController = navVC
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.buildMain(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
}



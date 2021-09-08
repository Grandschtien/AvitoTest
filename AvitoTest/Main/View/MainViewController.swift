//
//  ViewController.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 06.09.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    var presenter: MainViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        self.setupTableView()
    }

}

//MARK:- TableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.companyModel?.company?.employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let employee = presenter?.companyModel?.company?.employees?[indexPath.row]
        cell.textLabel?.text = employee?.name
        return cell
    }
    
    
}
//MARK:- TableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- Setup Table view

extension MainViewController {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
//MARK:- MainViewProtocol


extension MainViewController: MainViewProtocol {
    func success() {
        self.tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

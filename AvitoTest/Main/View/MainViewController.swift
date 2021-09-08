//
//  ViewController.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 06.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    private let label: UILabel = UILabel()
    var presenter: MainViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CompanyCell else { return UITableViewCell() }
        let employee = presenter?.companyModel?.company?.employees?[indexPath.row]
        cell.nameLabel.text = employee?.name
        cell.phoneNumberLabel.text = employee?.phoneNumber
        cell.skillsLabel.text = employee?.skills?.joined(separator: ", ")
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
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: CompanyCell.nib, bundle: nil), forCellReuseIdentifier: "Cell")
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
        self.title = presenter?.companyModel?.company?.name
    }
    
    func failure(error: Error) {
        setupLabel()
    }
}

//MARK: setup error of connection label
extension MainViewController {
    private func setupLabel() {
        tableView.isHidden = true
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.minimumScaleFactor = 0.01
        label.text = "Нет сети :("
        self.view.addSubview(label)
        setupConstraintsOfLabel()
    }
    private func setupConstraintsOfLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

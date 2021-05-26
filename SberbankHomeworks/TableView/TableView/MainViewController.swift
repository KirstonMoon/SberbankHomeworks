//
//  ViewController.swift
//  TableView
//
//  Created by Kirill Magerya on 25.05.2021.
//

import UIKit

protocol VisitedCell: AnyObject {
    
}

class MainViewController: UIViewController {
    
    private let cities = [City(name: "Moscow", isCheck: false),
                          City(name: "Paris", isCheck: false),
                          City(name: "New York", isCheck: false),
                          City(name: "Tokyo", isCheck: false),
                          City(name: "Beijing", isCheck: false),
                          City(name: "Sao Paulo", isCheck: false),
                          City(name: "Mumbai", isCheck: false),
                          City(name: "Los Angeles", isCheck: false),
                          City(name: "Istanbul", isCheck: false),
                          City(name: "London", isCheck: false)]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My cities"
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellId, for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let placeViewController = PlaceViewController()
        placeViewController.recievedPlace = cities[indexPath.row].name
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(placeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}

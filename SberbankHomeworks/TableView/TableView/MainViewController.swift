//
//  ViewController.swift
//  TableView
//
//  Created by Kirill Magerya on 25.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let visitedPlaces = ["Moscow",
                                 "Paris",
                                 "New York",
                                 "Tokyo",
                                 "Beijing",
                                 "Sao Paulo",
                                 "Mumbai",
                                 "Los Angeles",
                                 "Istanbul",
                                 "London"]
    
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
        visitedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellId, for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = visitedPlaces[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let placeViewController = PlaceViewController()
        placeViewController.recievedPlace = visitedPlaces[indexPath.row]
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(placeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}

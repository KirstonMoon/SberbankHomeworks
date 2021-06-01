//
//  ViewController.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let networkService: ItunesNetworkServiceProtocol
    
    private var dataSource = ItunesResponse(results: [Track(trackName: nil, artworkUrl100: "")]) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    init(networkService: ItunesNetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TrackCell.self, forCellReuseIdentifier: TrackCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        self.networkService.getTracks { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.dataSource = data
                case .failure( _):
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Не удалось отобразить данные", message: "Пожалуйста попробуйте еще раз", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellId, for: indexPath)
        (cell as? TrackCell)?.configure(with: dataSource.results[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let imageViewController = TrackImageViewController(networkService: networkService, trackImage: dataSource.results[indexPath.row].artworkUrl100)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}

//
//  DownloadViewController.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/17/22.
//

import UIKit

private let identifier = "TitleTableViewCell"

class DownloadViewController: UIViewController {
    
    //MARK: - Properties
    
    
    private let DownloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: identifier)
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }
    
    //MARK: - Helpers
    
    func configureNavBar(){
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        view.addSubview(DownloadedTable)
        DownloadedTable.delegate = self
        DownloadedTable.dataSource = self
    }
}

//MARK: - UITableViewDataSource

extension DownloadViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension DownloadViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
}

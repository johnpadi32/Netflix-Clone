//
//  UpcommingViewController.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/17/22.
//

import UIKit

private let identifer = "TitleTableViewCell"

class UpcommingViewController: UIViewController {
    
    //MARK: - Properties
    
    private var titles: [Title] = [Title]()
    
    private let upcomingTable: UITableView = {
       let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: identifer)
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upcomingTable.frame = view.bounds
    }
    
    //MARK: - API
    
    private func fetchUpcoming() {
        APIcaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureNavBar(){
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    }
}

//MARK: - UITableViewDataSource

extension UpcommingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.title) ?? "Unknown title name", posterURL: title.poster_path ?? "", overview: title.overview ?? ""))
        return cell
    }
}

//MARK: - UITableViewDelegate

extension UpcommingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.title else { return }
        
        APIcaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case  .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

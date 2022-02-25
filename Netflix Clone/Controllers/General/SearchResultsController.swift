//
//  SearchResultsController.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/24/22.
//

import UIKit

private let identifer = "TitleTableViewCell"

class SearchResultsController: UIViewController {
    
    //MARK: - Properties
    
    public var titles: [Title] = [Title]()

    public let searchResultsCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: identifer)
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    //MARK: - Helpers
    
    func configureNavBar(){
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource

extension SearchResultsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension SearchResultsController: UICollectionViewDelegate {
    
    
}

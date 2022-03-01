//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/17/22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var title: [Title] = [Title]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 123, height: 180)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    //MARK: - Helpers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(with title: [Title]) {
        self.title = title
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        print("Downloading \(title[indexPath.row].original_title)")
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionViewTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = title[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = title[indexPath.row]
        guard let titleName = title.original_title ?? title.title else { return }
        
        APIcaller.shared.getMovie(with: titleName + " trailer") { [weak self ] result in
            switch result {
            case .success(let videoElement):
                
                let title = self?.title[indexPath.row]
                guard let titleOverview = title?.overview else { return }
                let viewMdeol = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                guard let striongSelf = self else { return }
                self?.delegate?.collectionViewTableViewDidTapCell(striongSelf, viewModel: viewMdeol)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { [weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
}

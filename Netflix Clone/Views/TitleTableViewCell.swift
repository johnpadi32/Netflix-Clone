//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/23/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let titlePosterImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 3
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titlePosterImageView)
        titlePosterImageView.setDimensions(height: 145, width: 100)
        titlePosterImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [titleLable, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        addSubview(stack)
        stack.centerY(inView: titlePosterImageView, leftAnchor: titlePosterImageView.rightAnchor, paddingLeft: 8)
        stack.anchor(right: rightAnchor,paddingRight: 8)
        
        
//        addSubview(titleLable)
        addSubview(playTitleButton)
        playTitleButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 8)
        
//        appliedConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    
//    private func appliedConstraints() {
//        let titlePosterUIImageViewConstraints = [
//            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
//            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
//            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100)
//        ]
//
//        let titleLabelConstraints = [
//            titleLable.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor, constant: 20),
//            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ]
//
//        let playTitleButtonConstrains = [
//            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ]
//
//        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
//        NSLayoutConstraint.activate(titleLabelConstraints)
//        NSLayoutConstraint.activate(playTitleButtonConstrains)
//    }
    
    public func configure(with model: TitleViewModel) {        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }

        
        titlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLable.text = model.titleName
        overviewLabel.text = model.overview
    }
    
}

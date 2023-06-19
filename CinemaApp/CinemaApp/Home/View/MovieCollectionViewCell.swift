//
//  MovieCollectionViewCell.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit
import SnapKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: -- GUI Variables
    private lazy var imageView: GradientImageView = {
        let image = GradientImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 200))
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "movieImage")
        image.layer.masksToBounds = true

        return image
    }()
    
  private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
      label.textColor = .systemGray6.withAlphaComponent(1)
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Venom 2 film watching"
        
        return label
    }()
    
    //MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
           //addGradient()
        }
    
    //MARK: -- Methods
    func setup(movie: MovieCellViewModel, model: String) {
        if movie.title != nil {
            titleLabel.text = movie.title ?? movie.original_name
        } else {
            titleLabel.text = "No name"
        }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        
        imageView.sd_setImage(with: url)
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        addSubviews([imageView, titleLabel])
        
        setupConstraints()
    }
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}


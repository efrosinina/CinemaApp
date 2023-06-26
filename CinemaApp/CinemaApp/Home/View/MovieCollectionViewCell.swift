//
//  MovieCollectionViewCell.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit
import SnapKit
import SDWebImage
//MARK: -- Enum
enum State {
    case select, unselect
    
    var image: UIImage {
        switch self {
        case .select:
            return UIImage(systemName: "heart.fill") ?? UIImage.add
        case .unselect:
            return UIImage(systemName: "heart") ?? UIImage.add
        }
    }
}

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: -- GUI Variables
    private lazy var imageView: GradientImageView = {
        let image = GradientImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 200))
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        
        return image
    }()
    
    private lazy var favoriteImageView: UIImageView = {
        let view = UIImageView()
        view.image = State.unselect.image
        view.tintColor = .red
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray6.withAlphaComponent(1)
        label.font = .boldSystemFont(ofSize: 16)
        
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
    
    //MARK: -- Methods
    func setup(movie: MovieCellViewModel, model: String, selected: Bool) {
        titleLabel.text = movie.title ?? movie.originalName
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        imageView.sd_setImage(with: url)
        favoriteImageView.image = selected ? State.select.image : State.unselect.image
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        addSubviews([imageView, titleLabel, favoriteImageView])
        setupConstraints()
    }
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
        }
        
        favoriteImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
    }
}

//
//  ExploreTableViewCell.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit
import SnapKit

class ExploreTableViewCell: UITableViewCell {
    //MARK: -- GUI Variables
    private lazy var filmImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = .max
        
        return label
    }()
    
    //MARK: -- Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Methods
    func setup(movie: MovieCellViewModel, model: String) {
        titleLabel.text = movie.title ?? movie.originalName
        descriptionLabel.text = movie.overview
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        filmImage.sd_setImage(with: url)
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        addSubviews([filmImage, lineView, titleLabel, descriptionLabel])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(5)
        }
        
        filmImage.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(filmImage.snp.trailing).offset(10)
            make.top.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(filmImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}

//
//  FavoriteTableViewCell.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 19/06/2023.
//

import UIKit
import SnapKit

class FavoriteTableViewCell: UITableViewCell {
    //MARK: -- GUI Variables
    private lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var filmLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
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
    func setupCell(movie: MovieCellViewModel) {
        filmLabel.text = movie.title ?? movie.original_name
        releaseDate.text = movie.release_date
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        addSubviews([releaseDate, filmLabel])
        setupConstraints()
    }
    
    private func setupConstraints() {
        filmLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        releaseDate.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
    }
}

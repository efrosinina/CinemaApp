//
//  FilmViewController.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit
import SnapKit
import SDWebImage
import WebKit

class FilmViewController: UIViewController {
    //MARK: -- GUI Variables
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 5
        
        return view
    }()
    
    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .yellow
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = .max
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = .max
        
        return label
    }()
    
    //MARK: -- Properties
    private var viewModel: FilmViewModelProtocol
    
    //MARK: -- Initialization
    init(viewModel: FilmViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        let views = [titleLabel, imageView, starImageView, voteLabel, releaseDateLabel, descriptionLabel, webView]
        views.forEach { view in
            view.isUserInteractionEnabled = true
        }
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(views)
        
        configureView()
        setupConstraints()
    }
    
    func configureView() {
        titleLabel.text = viewModel.title ?? viewModel.original_name
        descriptionLabel.text = viewModel.overview
        releaseDateLabel.text = viewModel.release_date
        voteLabel.text = "\(String(format: "%.1f", viewModel.vote_average)) / 10 IMDb"
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.poster_path ?? "")")
        imageView.sd_setImage(with: url)
        
        viewModel.loadData(wkView: webView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(320)
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.leading)
        }
        
        voteLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(starImageView.snp.trailing).offset(2)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(voteLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}

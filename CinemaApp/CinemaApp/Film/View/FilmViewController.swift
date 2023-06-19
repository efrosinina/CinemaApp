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
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal // Вертикальный стэк
        view.distribution = .fillEqually // Выравнивание элементов в стэке
        view.alignment = .center // вертикальное выравнивание контента в стэке
        view.spacing = 5 // Расстояние между объектами в стэке
        
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
        view.image = UIImage(named: "ZiClJf-1920w")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2019"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.text = "8.5"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "jsdfdjfhdjfjdkfjdkfjdrfgfgtfghfgfgfgfgfgfgfgfgfgfgfgfgrtirtrutriuhjdfnvvbghderwhuijqkolap;Z.X,CVBNM,LIUYTR"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = .max
        return label
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .blue
        return view
    }()
    
    //MARK: -- Properties
    private let edgesInset = 30
    private let viewModel: FilmViewModelProtocol
    
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
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([titleLabel, imageView, starImageView, voteLabel, releaseDateLabel, playButton, descriptionLabel, webView])
        
        configureView()
        setupConstraints()
    }
    
    private func configureView() {
        titleLabel.text = viewModel.title ?? viewModel.original_name
        
        descriptionLabel.text = viewModel.overview
        releaseDateLabel.text = viewModel.release_date
        voteLabel.text = "\(String(format: "%.1f", viewModel.vote_average)) / 10 IMDb"
        
       let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.poster_path ?? "")")
        imageView.sd_setImage(with: url)
        
        guard let youtubeUrl = URL(string: "https://www.youtube.com/embed/\(viewModel.youtubeView?.id.videoId ?? "")") else { return }
        webView.load(URLRequest(url: youtubeUrl))
    }
  
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
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
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(voteLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

//
//  ExploreViewController.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit

class ExploreViewController: UIViewController {
    //MARK: -- GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
       // searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ExploreTableViewCell.self, forCellReuseIdentifier: "ExploreTableViewCell")
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    //MARK: -- Properties
    private var viewModel: MoviesViewModelProtocol
    
    //MARK: -- Initializations
    init(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.frame = view.bounds
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.tableView.reloadRows(at: [IndexPath(row: row,
                                                      section: 0)], with: .automatic)
        }
        
        viewModel.showError = { error in
            //TODO: show alert
            print(error)
        }
    }
}

//MARK: -- UITableViewDataSource
extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as? ExploreTableViewCell else { return UITableViewCell() }
        
        let movie = viewModel.getMovie(for: indexPath.row)
        guard let image = viewModel.getMovie(for: indexPath.row).poster_path else { return UITableViewCell() }
        cell.setup(movie: movie, model: image)
        
        return cell
    }
}

extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


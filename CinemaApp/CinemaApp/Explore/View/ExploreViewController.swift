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
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - searchBar.frame.height))
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
    private var viewModel: ExploreViewModelProtocol
    
    //MARK: -- Initializations
    init(viewModel: ExploreViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        view.addSubviews([searchBar, tableView])
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let movie = viewModel.getMovie(for: indexPath.row)
            //guard let titleName = movie.title else { return }
        navigationController?.pushViewController(FilmViewController(viewModel: FilmViewModel(movie: movie)), animated: true)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    //func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
    //        viewModel
}

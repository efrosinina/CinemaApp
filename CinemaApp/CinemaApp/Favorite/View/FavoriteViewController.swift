//
//  FavoriteViewController.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit

class FavoriteViewController: UITableViewController {
    //MARK: -- Properties
    var favoriteFilm: [MovieCellViewModel] = []
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar .prefersLargeTitles = true
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchFavorite()
    }
    
    //MARK: -- Private Methods
    private func fetchFavorite() {
        guard let moviesData = UserDefaults.standard.object(forKey: "movies") as? Data,
              let movies = try? JSONDecoder().decode([MovieCellViewModel].self, from: moviesData) else { return }
        favoriteFilm = movies
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(FavoriteTableViewCell.self,
                           forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.separatorColor = .black
        tableView.rowHeight = 50
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.width, right: 0)
    }
    
    //MARK: -- UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFilm.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell",
                                                       for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let movie = favoriteFilm[indexPath.row]
        cell.setupCell(movie: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favoriteFilm.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

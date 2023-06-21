//
//  TabBarController.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit

final class TabBarController: UITabBarController {
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewController()
    }
    
    //MARK: -- Private methods
    private func setupViewController() {
        viewControllers = [
            setupNavigationController(rootViewController: HomeViewController(viewModel: MoviesViewModel()),
                                      title: "Home",
                                      image: UIImage(systemName: "house") ?? UIImage.add),
            setupNavigationController(rootViewController: ExploreViewController(viewModel: ExploreViewModel()),
                                      title: "Explore",
                                      image: UIImage(systemName: "magnifyingglass") ?? UIImage.add),
            setupNavigationController(rootViewController: FavoriteViewController(),
                                      title: "Favorite",
                                      image: UIImage(systemName: "heart") ?? UIImage.add)
        ]
        setupTabBar()
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    
    private func setupTabBar() {
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = apperance
        view.tintColor = .black
    }
}

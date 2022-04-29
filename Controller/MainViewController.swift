//
//  MainViewController.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/28.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    private lazy var searchBar: UISearchController = {
        let searchBar = UISearchController()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
 
    private func setupNavigationBar() {
        navigationItem.title = "지하철 도착 정보"
        navigationItem.searchController = searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MainViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        tableView.isHidden = false
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        tableView.isHidden = true
    }
}

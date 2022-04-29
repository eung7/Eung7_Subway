//
//  MainViewController.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/28.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
//        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "지하철 도착 정보"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MainTableViwCell")
        
        var contents = cell.defaultContentConfiguration()
        contents.text = "안녕하세요 !!"
        contents.secondaryText = "저는 김응철입니다."
        cell.contentConfiguration = contents

        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hi! I'm \(indexPath.row)")
    }
}

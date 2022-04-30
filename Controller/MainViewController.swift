//
//  MainViewController.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/28.
//

import SnapKit
import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var stations: [Station] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSubway(with: "서울역")
        
        print(stations)
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
    
    func fetchSubway(with station: String) {
        let url = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(station)"
        
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: SearchInfoBySubwayNameServiceModel.self) {[weak self] res in
                switch res.result {
                case .success(let response):
                    self?.stations = response.searchInfo.row
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
        let vc = DetailViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

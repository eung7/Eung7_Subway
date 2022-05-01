//
//  DetailViewController.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/29.
//

import UIKit
import SnapKit
import Alamofire

class DetailViewController: UIViewController {
    
    let stationName: String?
    
    var stationArvlInfo: [realtimeArrival] = []
    
    init(stationName: String) {
        self.stationName = stationName
        super.init(nibName: nil, bundle: nil)
        
        fetchData(with: stationName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = stationName
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func fetchData(with stationName: String) {
        let url = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
                
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: RealtimeStationArrivalModel.self) {[weak self] res in
                switch res.result {
                case .success(let data):
                    self?.stationArvlInfo = data.realtimeArrivalList
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationArvlInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        let arvlInfo = stationArvlInfo[indexPath.row]
        cell.setupData(stationName: arvlInfo.line, arvlMsg: arvlInfo.remainingTime)
        cell.setupUI()
        
        return cell
    }
}

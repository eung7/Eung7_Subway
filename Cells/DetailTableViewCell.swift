//
//  DetailTableViewCell.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/29.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "안녕하세요"
        
        return label
    }()
    
    private lazy var remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.text = "안녕하세요"
        
        return label
    }()
    
    func setupUI() {
        [ destinationLabel, remainingTimeLabel ]
            .forEach { contentView.addSubview($0) }
        
        destinationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        remainingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(destinationLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

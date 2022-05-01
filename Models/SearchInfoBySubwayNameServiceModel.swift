//
//  SearchInfoBySubwayNameService.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/04/30.
//

import Foundation

struct SearchInfoBySubwayNameServiceModel: Decodable {
    
    let searchInfo: SearchInfoBySubwayNameService
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameService: Decodable {
        var row: [Station]
    }
}

struct Station: Codable {
    let name: String
    let line: String
    
    enum CodingKeys: String, CodingKey {
        case name = "STATION_NM"
        case line = "LINE_NUM"
    }
}


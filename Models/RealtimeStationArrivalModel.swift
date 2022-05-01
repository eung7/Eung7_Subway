//
//  RealtimeStationArrivalModel.swift
//  Eung7_Subway
//
//  Created by 김응철 on 2022/05/01.
//

import Foundation

struct RealtimeStationArrivalModel: Decodable {
    var realtimeArrivalList: [realtimeArrival] = []
    
}

struct realtimeArrival: Decodable {
    let line: String
    let remainingTime: String
    let currentStation: String
    
    enum CodingKeys: String, CodingKey {
        case line = "statnNm"
        case remainingTime = "arvlMsg2"
        case currentStation = "arvlMsg3"
    }
}



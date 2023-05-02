//
//  SugarLevel.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/5/2.
//

import Foundation

enum SugarLevel {
    case 正常糖, 少糖, 半糖, 微糖, 二分糖, 一分糖, 無糖
    
    func getSugarLevelIndex(sugarLevel: SugarLevel) -> Int {
        switch sugarLevel {
        case .正常糖:
            return 0
        case .少糖:
            return 1
        case .半糖:
            return 2
        case .微糖:
            return 3
        case .二分糖:
            return 4
        case .一分糖:
            return 5
        case .無糖:
            return 6
        }
    }
    
    func getSugarLevelName(sugarLevelIndex: Int) -> String {
        switch sugarLevelIndex {
        case 0:
            return "全糖"
        case 1:
            return "少糖"
        case 2:
            return "半糖"
        case 3:
            return "微糖"
        case 4:
            return "二分糖"
        case 5:
            return "一分糖"
        case 6:
            return "無糖"
        default:
            return ""
        }
    }
}

//
//  Meds.swift
//  Mental
//
//  Created by 黄子恒 on 2023/5/26.
//

import Foundation

struct Meds: Hashable, Codable, Identifiable {
    var id : Int
    let medDose: String
    let medKind: String
    let medReminders: Date
    let medType: String
    let medUnit: String
}

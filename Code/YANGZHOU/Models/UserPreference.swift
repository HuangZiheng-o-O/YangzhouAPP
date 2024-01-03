//
//  UserPreference.swift
//  Yangzhou
//

import Foundation
struct UserPreference : Hashable, Codable, Identifiable {
    var id:Int
    var likedUserId:[Int]=[]
    var staredUserId:[Int]=[]
}

//
//  Wishlist.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation
import FirebaseFirestoreSwift

struct Wishlist: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var userid: Int
  var wishlist: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case userid
    case wishlist
  }
}

struct WishRow: Identifiable, Codable {
  var id = UUID()
  var rowRating: Double
  var product: String
  var alc: Double
  var rowPhoto: String
  var style: String
  
  enum CodingKeys: String, CodingKey {
    case rowRating
    case product
    case alc
    case rowPhoto
    case style
  }
}


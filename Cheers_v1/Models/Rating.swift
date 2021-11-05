//
//  Rating.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation
import FirebaseFirestoreSwift

struct Rating: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var rating: Double
  var userid: Int
  var product: String
  var tags: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case rating
    case userid
    case product = "productname"
    case tags
  }
}

struct RatingRow: Identifiable, Codable {
  var id = UUID()
  var rowRating: Double
  var product: String
  var alc: Int
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

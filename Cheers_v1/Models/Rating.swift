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
  var datetime: Date
  var photo: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case rating
    case userid
    case product = "productname"
    case tags
    case datetime
    case photo
  }
}

struct RatingRow: Identifiable, Codable {
  var id = UUID()
  var rowRating: Double
  var product: String
  var alc: Double
  var rowPhoto: String
  var style: String
  var dateString: String
  
  enum CodingKeys: String, CodingKey {
    case rowRating
    case product
    case alc
    case rowPhoto
    case style
    case dateString
  }
}

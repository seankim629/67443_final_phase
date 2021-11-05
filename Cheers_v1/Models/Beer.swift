//
//  Beer.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation
import FirebaseFirestoreSwift

struct Beer: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var abv: Int
  var sour: Int
  var astring: Int
  var key: Int
  var style: String
  var malty: Int
  var alcohol: Int
  var bitter: Int
  var avgRating: Double
  var description: String
  var name: String
  var fruits: Int
  var spices: Int
  var hoppy: Int
  var sweet: Int
  var salty: Int
  
  
  enum CodingKeys: String, CodingKey {
    case abv = "ABV"
    case sour = "Sour"
    case astring = "Astringency"
    case key
    case style = "Style"
    case malty = "Malty"
    case alcohol = "Alcohol"
    case bitter = "Bitter"
    case avgRating = "Ave Rating"
    case description = "Description"
    case name = "Name"
    case fruits = "Fruits"
    case spices = "Spices"
    case hoppy = "Hoppy"
    case sweet = "Sweet"
    case salty = "Salty"
  }
}

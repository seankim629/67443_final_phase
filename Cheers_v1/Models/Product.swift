//
//  Product.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation

struct Result: Decodable {
    let products : [ResultProds]
    
    enum CodingKeys : String, CodingKey {
      case products
    }
}

struct ResultProds: Decodable {
  let name: String
  let image: String
  
  enum CodingKeys : String, CodingKey {
    case name = "product_name"
    case image = "product_image_url"
  }
}

struct Product {
  var name: String = ""
  var fakeName: String = ""
  var image: String = ""
  var avgRating: Double = 0.0
  var alc: Double = 0.0
  var brewery: String = ""
  var style: String = ""
  var sweet: Int = 0
  var sour: Int = 0
  var bitter: Int = 0
  var fruits: Int = 0
  
}

//
//  Product.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation

struct Result: Decodable {
    let products : [Product]
    
    enum CodingKeys : String, CodingKey {
      case products
    }
}


struct Product: Decodable {
  let name: String
  let image: String
  
  enum CodingKeys : String, CodingKey {
    case name = "product_name"
    case image = "product_image_url"
  }
}

//
//  User.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/02.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct User: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var email: String
  var name: String
  var photo: String
  var ratings: [DocumentReference]
  var wishlist: DocumentReference
  var nopeList: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case email
    case name
    case photo
    case ratings
    case wishlist
    case nopeList
  }
  
  //toAny() object (Refer to Arbeit Repo) 
}

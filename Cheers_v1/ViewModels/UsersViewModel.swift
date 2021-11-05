//
//  UsersViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore

class UsersViewModel: ObservableObject {
  @Published var users = [User]()
  
  private var db = Firestore.firestore()
  
  func getUserData() {
    db.collection("users").getDocuments {
      querySnapshot, error in
          guard let documents = querySnapshot?.documents else {
                print("No documents! \(error!)")
                //completion(nil)
                return
            }
      self.users = documents.map { (queryDocumentSnapshot) -> User in
        let data = queryDocumentSnapshot.data()
        
        let docId = queryDocumentSnapshot.documentID
        let email = data["email"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let photo = data["photo"] as! DocumentReference
        let ratings = data["ratings"] as? [DocumentReference] ?? []
        let wishlist = data["wishlist"] as! DocumentReference
        let u1 = User(id: docId, email: email, name: name, photo: photo, ratings: ratings, wishlist: wishlist)
        return u1
      }

    }
  }
}

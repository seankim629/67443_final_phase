//
//  WishesViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore

class WishesViewModel: ObservableObject {
  @Published var wishes = [WishRow]()
  
  private var db = Firestore.firestore()
  
  func getWishList(wlist: DocumentReference) {
      wlist.getDocument { document, error in
        if let error = error as NSError? {
          "Reference not found"
        }
        else {
          if let document = document {
            do {
                let data = document.data()
                let docId = document.documentID
                let userid = data?["userid"] as? Int ?? 0
                let wishlist = data?["wishlist"] as? [String] ?? []
                
                let w1 = Wishlist(id: docId, userid: userid, wishlist: wishlist)
                
//                print("-----------------------------------")
//                print("Printing Wishlist Products by User ID: \(w1.userid)")
                for w in w1.wishlist {
                  //print("Rated Product: \(w)")
                    let beerRef = self.db.collection("beers").document(w)
                    beerRef.getDocument { document, error in
                      if let error = error as NSError? {
                        "Reference not found"
                      }
                      else {
                        if let document = document {
                          do {
                            let data = document.data()
                            let name = data?["Name"] as? String ?? ""
                            let alc = data?["ABV"] as? Double ?? 0.0
                            let avgR = data?["Ave Rating"] as? Double ?? 0.0
                            let style = data?["Style"] as? String ?? ""
                            self.wishes.append(WishRow(rowRating: avgR, product: w, alc: alc, rowPhoto: "", style: style))
                          }
                          catch {
                            print(error)
                          }
                        }
                      }
                    }
                }
              }
          }
        }
      }
  }


  func testGetWishList() {
    let uid = UserDefaults.standard.string(forKey: "uid")
    print(uid)
    let userRef = db.collection("users").document(uid as? String ?? "")
    userRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let usrWish = data?["wishlist"] as? DocumentReference ?? nil
            if usrWish != nil {
              self.getWishList(wlist: usrWish!)
            }
          }
          catch {
            print(error)
          }
        }
      }
    }

  }
  
  func isInWishlist(usrID: String, beerName: String, completion:@escaping((Bool) -> ())) {
    let myGroup = DispatchGroup()
    let userRef = db.collection("users").document(usrID)
    var isThere = false
    myGroup.enter()
    userRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let wishlists = data?["wishlist"] as? DocumentReference ?? nil
            if wishlists == nil {
              print("HERERERE?")
              isThere = false
            }
            else {
                myGroup.enter()
                wishlists!.getDocument { document, error in
                  if let error = error as NSError? {
                    "Reference not found"
                  }
                  else {
                    if let document = document {
                      do {
                        let data = document.data()
                        print(document.documentID)
                        let urid = data?["userid"] as? Int ?? 0
                        print(urid)
                        let wishes = data?["wishlist"] as? [String] ?? []
                        print(wishes)
                        print(beerName)
                        for w in wishes {
                          if w == beerName {
                            isThere = true
                          }
                        }
                      }
                    }
                  }
                  myGroup.leave()
                }
            }
          }
        }
      }
      myGroup.leave()
    }
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
      print(isThere)
      completion(isThere)
    }
  }
  
  func checkWishlist(usrID: String, beerName: String, isAdd: Bool) {
    var isNew = false
    var count = 1
    let lastchr = usrID.last!
    let newData = [
      "userid": Int(String(lastchr)) ?? 0,
      "wishlist": [beerName]
    ] as [String : Any]
    let myGroup = DispatchGroup()
    let userRef = db.collection("users").document(usrID)
    myGroup.enter()
    userRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let wishlists = data?["wishlist"] as? DocumentReference ?? nil
            if wishlists == nil {
              isNew = true
            } else {
              myGroup.enter()
              if isAdd == true {
                print("DO THE ADD")
                wishlists?.updateData([
                  "wishlist": FieldValue.arrayUnion([beerName])
                ])
              } else {
                print("DO THE DELETE")
                wishlists?.updateData([
                  "wishlist": FieldValue.arrayRemove([beerName])
                ])
              }
              myGroup.leave()
            }
          }
        }
      }
    myGroup.leave()
    }
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
        if isNew == true {
          print("NEW??")
          let newID = usrID + "_wishlist"
          self.addNewWishlist(newID: newID, newData: newData)
          userRef.updateData([
              "wishlist": self.db.document("wishlist/\(newID)")
          ])
        }
    }

  }
  
  
  func addNewWishlist(newID: String, newData: [String:Any]) {
    db.collection("wishlist").document(newID).setData(newData) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Test Document successfully written!")
        }
    }
    
//    let docRef = db.collection("wishlist").document("wtesting2")
//    docRef.getDocument { (document, error) in
//      print("Checking if document is actually added!")
//      if ((document?.exists) != nil) {
//        print("Document added!")
//        print("Document data: \(document?.data())")
//          } else {
//             print("Document does not exist")
//          }
//    }
  }

  func updateWishlist(docID: String, updateData: [String:Any]) {
    let wRef = db.collection("wishlist").document("wtesting2")

    wRef.updateData(updateData) { err in
        if let err = err {
            print("Error updating document: \(err)")
        } else {
            print("Test Document successfully updated")
        }
    }
    wRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
              let data = document.data()
              let wishlist = data?["wishlist"] as? [String] ?? []
              print("+++++++++++++++++++++++++++++++++++")
              print("Printing Updated Wishlist with newly added product")
              for w in wishlist {
                print("Rated Product: \(w)")
              }
              print("Successfully showed loaded data on this wishlist.")
              print("+++++++++++++++++++++++++++++++++++")

          }
          catch {
            print(error)
          }
        }
      }
    }
  }

  func deleteWishlist(docID: String) {
    db.collection("wishlist").document(docID).delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Test Document successfully removed!")
        }
    }
    let docRef = db.collection("wishlist").document(docID)
    docRef.getDocument { (document, error) in
      print("Checking if document actually exists!")
      if ((document?.exists) != nil) {
        print("Document still exists!")
        print("Document data: \(document?.data())")
          } else {
             print("Nice. Document does not exist!")
          }
    }
  }
}

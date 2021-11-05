//
//  RatingsViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore

class RatingsViewModel: ObservableObject {
  @Published var ratings = [RatingRow]()
  
  private var db = Firestore.firestore()
  
  func getRatingList(rlist: [DocumentReference]) {
    for rat in rlist {
      rat.getDocument { document, error in
        if let error = error as NSError? {
          "Reference not found"
        }
        else {
          if let document = document {
            do {
                let data = document.data()
                let docId = document.documentID
                let rating = data?["rating"] as? Double ?? 0.0
                let userid = data?["userid"] as? Int ?? 0
                let product = data?["productname"] as? String ?? ""

                let tags = data?["tags"] as? [String] ?? []
                
                let r2 = Rating(id: docId, rating: rating, userid: userid, product: product, tags: tags)
                self.db.collection("beers").getDocuments {
                  querySnapshot, error in
                      guard let documents = querySnapshot?.documents else {
                            print("No documents! \(error!)")
                            return
                        }
                      for documentSnapshot in documents {
                        let data = documentSnapshot.data()
                        let name = data["Name"] as? String ?? ""
                        if name == product {
                          let alc = data["Alcohol"] as? Int ?? 0
                          let style = data["Style"] as? String ?? ""
                          self.ratings.append(RatingRow(rowRating: rating, product: product, alc: alc, rowPhoto: "", style: style))
                          break
                        }
                      }
                  }
//                print("-----------------------------------")
//                print("Printing Rated Product")
//                print("Rated Product: \(r2.product)")
//                print("Rating of this product: \(r2.rating)")
//                var count = 0
//                for t in r2.tags {
//                  count += 1
//                  print("Tag \(String(count)) of current Product: \(t)")
//                }
//                print("Successfully showed loaded data on this rating.")
//                print("-----------------------------------")

            }
            catch {
              print(error)
            }
          }
        }
      }
    }

  }

  func testGetRatingList() {
    let userRef = db.collection("users").document("uesrid_1")
    userRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let ratings = data?["ratings"] as? [DocumentReference] ?? []
            self.getRatingList(rlist: ratings)
          }
          catch {
            print(error)
          }
        }
      }
    }
  }

  func addRating(newData: [String:Any]) {
    db.collection("ratings").document("testing2").setData(newData) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Test Document successfully written!")
        }
    }
    let docRef = db.collection("ratings").document("testing2")
    docRef.getDocument { (document, error) in
      print("Checking if document is actually added!")
      if ((document?.exists) != nil) {
        print("Docudment added!")
        print("Document data: \(document?.data())")
          } else {
             print("Document does not exist")
          }
    }
  }

  func updateRating(docID: String, updateData: [String:Any]) {
    let rRef = db.collection("ratings").document("testing2")

    rRef.updateData(updateData) { err in
        if let err = err {
            print("Error updating document: \(err)")
        } else {
            print("Test Document successfully updated")
        }
    }
    rRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
              let data = document.data()
              let rating = data?["rating"]
              print("+++++++++++++++++++++++++++++++++++")
              print("Printing Updated Rating with changed input")
              print("New rating is: \(rating)")
              print("Successfully showed loaded data on this rating.")
              print("+++++++++++++++++++++++++++++++++++")

          }
          catch {
            print(error)
          }
        }
      }
    }
  }

  func deleteRating(docID: String) {
    db.collection("ratings").document(docID).delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Test Document successfully removed!")
        }
    }
    let docRef = db.collection("ratings").document(docID)
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

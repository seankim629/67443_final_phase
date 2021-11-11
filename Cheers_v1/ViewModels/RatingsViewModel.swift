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
                let datetime = data?["datetime"] as! Timestamp
                let convdate = datetime.dateValue()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/YY"
                let formattedTimeZoneStr = formatter.string(from: convdate)
                let tags = data?["tags"] as? [String] ?? []
                
                let r2 = Rating(id: docId, rating: rating, userid: userid, product: product, tags: tags, datetime: convdate)
                let beerRef = self.db.collection("beers").document(product)
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
                        let style = data?["Style"] as? String ?? ""
                        self.ratings.append(RatingRow(rowRating: rating, product: product, alc: Double(alc), rowPhoto: "", style: style, dateString: formattedTimeZoneStr))
                      }
                      catch {
                        print(error)
                      }
                    }
                  }
                }
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

  func checkRating(newData: [String:Any]) {
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
            if ratings.count == 0 {
              self.addRating(newData: newData)
            } else {
              // if no ratings done for the current product, add ratings
              // if yes, then update ratings
              for rat in ratings {
                rat.getDocument { document, error in
                  if let error = error as NSError? {
                    "Reference not found"
                  }
                  else {
                    if let document = document {
                      do {
                          let data = document.data()
                          let docId = document.documentID
                          let userid = data?["userid"] as? Int ?? 0
                          let product = data?["productname"] as? String ?? ""
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

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
  private var found = false
  private var db = Firestore.firestore()
  
  func hasTags(usrID: String, beerName: String, completion:@escaping((([String],Double)) -> ())) {
    var resTags = [String]()
    var beerRating = Double()
    let myGroup = DispatchGroup()
    let usrRef = db.collection("users").document(usrID)
    var cnt = 1
    myGroup.enter()
    usrRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let ratings = data?["ratings"] as? [DocumentReference] ?? []
            var found = false
            for rat in ratings {
              cnt += 1
              if found == false {
                myGroup.enter()
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
                          if product == beerName {
                            print("EXISTSSTSTSTTS!")
                            UserDefaults.standard.set(docId, forKey: "ratingid")
                            found = true
                            if tags == [] {
                              resTags = []
                              beerRating = rating
                            } else {
                              resTags = tags
                              beerRating = rating
                            }
                          }
                      }
                      catch {
                        print(error)
                      }
                    }
                  }
                myGroup.leave()
                }
              }
            }
          }
          catch {
            print(error)
          }
        }
      }
      myGroup.leave()
    }
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
        completion((resTags,beerRating))
        UserDefaults.standard.set(cnt, forKey: "ratingcnt")
    }
  }
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
                let photo = data?["photo"] as? String ?? ""
                
                let r2 = Rating(id: docId, rating: rating, userid: userid, product: product, tags: tags, datetime: convdate, photo: photo)
                if rating != 0.0 {
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
                          self.ratings.append(RatingRow(rowRating: rating, product: product, alc: Double(alc), rowPhoto: photo, style: style, dateString: formattedTimeZoneStr))
                        }
                        catch {
                          print(error)
                        }
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
    let uid = UserDefaults.standard.string(forKey: "uid")
    let userRef = db.collection("users").document(uid ?? "")
    
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

  func checkRating(usrID: String, newData: [String:Any]) {
    var isCheck = false
    var count = 1
    let myGroup = DispatchGroup()
    var inputData = [
      "datetime": newData["datetime"],
      "rating": newData["rating"],
      "userid": newData["userid"],
      "productname": newData["productname"],
      "tags": newData["tags"],
      "photo": newData["photo"]
    ]
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
            let ratings = data?["ratings"] as? [DocumentReference] ?? []
              // if no ratings done for the current product, add ratings
              // if yes, then update ratings
            for rat in ratings {
              count += 1
              if isCheck == false {
                myGroup.enter()
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
                          let target = newData["productname"] as? String ?? ""
                          let rating = data?["rating"] as? Double ?? 0.0
                          print(target)
                          print("+++++++++++")
                          print(product)
                          if product == target {
                            isCheck = true
                            
                            if newData["rating"] as! Double == 0.0 {
                              inputData["rating"] = rating
                            }
                            //myGroup.enter()
                            self.updateRating(docID: docId, updateData: inputData)
                            //myGroup.leave()
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
      }
    myGroup.leave()
    }
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
        if isCheck == false {
          print(isCheck)
          let newID = usrID + "_r\(count)"
          self.addRating(docID: newID, newData: newData)
        }
    }

  }
  
  func addRating(docID: String, newData: [String:Any]) {
    db.collection("ratings").document(docID).setData(newData) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Test Document successfully written!")
        }
    }
    let uid = UserDefaults.standard.string(forKey: "uid")!
    let userRef = db.collection("users").document(uid)
    userRef.updateData([
        "ratings": FieldValue.arrayUnion([self.db.document("ratings/\(docID)")])
    ])

//    let docRef = db.collection("ratings").document(docID)
//    docRef.getDocument { (document, error) in
//      print("Checking if document is actually added!")
//      if ((document?.exists) != nil) {
//        print("Docudment added!")
//        print("Document data: \(document?.data())")
//          } else {
//             print("Document does not exist")
//          }
//    }
  }

  func updateRating(docID: String, updateData: [String:Any]) {
    let rRef = db.collection("ratings").document(docID)

    rRef.updateData(updateData) { err in
        if let err = err {
            print("Error updating document: \(err)")
        } else {
            print("Test Document successfully updated")
        }
    }
//    rRef.getDocument { document, error in
//      if let error = error as NSError? {
//        "Reference not found"
//      }
//      else {
//        if let document = document {
//          do {
//              let data = document.data()
//              let rating = data?["rating"]
//              print("+++++++++++++++++++++++++++++++++++")
//              print("Printing Updated Rating with changed input")
//              print("New rating is: \(rating)")
//              print("Successfully showed loaded data on this rating.")
//              print("+++++++++++++++++++++++++++++++++++")
//
//          }
//          catch {
//            print(error)
//          }
//        }
//      }
//    }
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

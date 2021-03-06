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
              for documentSnapshot in documents {
                let data = documentSnapshot.data()

                let docId = documentSnapshot.documentID
                let email = data["email"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let photo = data["photo"] as? String ?? ""
                let ratings = data["ratings"] as? [DocumentReference] ?? []
                let wishlist = data["wishlist"] as! DocumentReference
                let nopeList = data["nopeList"] as? [String] ?? []
                let prefTags = data["preferenceTags"] as? [String] ?? []
                let u1 = User(id: docId, email: email, name: name, photo: photo, ratings: ratings, wishlist: wishlist, nopeList: nopeList, preferenceTags: prefTags)
                self.users.append(u1)
              }

        }
      }

      func checkUser(email:String, name:String, photo:String, completion:@escaping((Bool) -> ())) {
        var found = false
        let myGroup = DispatchGroup()
        myGroup.enter()
        db.collection("users").getDocuments {
          querySnapshot, error in
              guard let documents = querySnapshot?.documents else {
                    print("No documents! \(error!)")
                    //completion(nil)
                    return
              }
              for documentSnapshot in documents {
                let data = documentSnapshot.data()
                let em = data["email"] as? String ?? ""
                let docId = documentSnapshot.documentID
                let nopeList = data["nopeList"] as? [String] ?? []
                let prefList = data["preferenceTags"] as? [String] ?? []
                if (em == email) {
                  found = true
                  UserDefaults.standard.set(docId, forKey: "uid")
                  UserDefaults.standard.set(nopeList, forKey: "nope")
                  UserDefaults.standard.set(prefList, forKey: "pref")
                  break
                }
              }
        myGroup.leave()
        }
        myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
          print("REACHING HERE?")
          UserDefaults.standard.set(true, forKey: "homeTeamName")
          if found == false {
            var newData = [
              "email": email,
              "name": name,
              "photo": photo,
              "ratings": [DocumentReference](),
              "wishlist": nil,
              "nopeList": [],
              "preferenceTags": []
            ] as [String : Any?]
            UserDefaults.standard.set([], forKey: "nope")
            UserDefaults.standard.set([], forKey: "pref")
            self.addUser(newData: newData, completion: { (success) -> Void in
              if success {
                completion(true)
              }
            })
          } else {
            completion(true)
          }
          
        }
      }

      func addUser(newData: [String:Any], completion:@escaping((Bool) -> ())) {
        var cnt = 1
        let myGroup = DispatchGroup()
        myGroup.enter()
        db.collection("users").getDocuments {
          querySnapshot, error in
              guard let documents = querySnapshot?.documents else {
                    print("No documents! \(error!)")
                    //completion(nil)
                    return
              }
          for _ in documents {
            cnt += 1
          }
          myGroup.leave()
        }
        myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
          let uid = "usr_\(cnt)"
          UserDefaults.standard.set(uid, forKey: "uid")
          self.db.collection("users").document(uid).setData(newData) { err in
              if let err = err {
                  print("Error writing document: \(err)")
                  completion(false)
              } else {
                  print("Test Document successfully written!")
                  completion(true)
              }
              
          }

        }
      }
      func addNope(newNope: String) {
            let uid = UserDefaults.standard.string(forKey: "uid")!
            var usrNope = UserDefaults.standard.object(forKey: "nope") as! [String]
            usrNope.append(newNope)
            UserDefaults.standard.set(usrNope, forKey: "nope")
            let userRef = db.collection("users").document(uid)
            userRef.updateData([
                "nopeList": FieldValue.arrayUnion([newNope])
            ]) { err in
              if let err = err {
                  print("Error updating document: \(err)")
              } else {
                  print("Test Document successfully updated")
              }
          }
      }
  
      func addPref(newPref: [String]) {
            let uid = UserDefaults.standard.string(forKey: "uid")!
            UserDefaults.standard.set(newPref, forKey: "pref")
            let userRef = db.collection("users").document(uid)
            userRef.updateData([
              "preferenceTags": newPref
            ]) { err in
              if let err = err {
                  print("Error updating document: \(err)")
              } else {
                  print("Test Document successfully updated")
              }
          }
      }
}

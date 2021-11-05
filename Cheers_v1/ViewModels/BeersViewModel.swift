//
//  BeersViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore

class BeersViewModel: ObservableObject {
  @Published var beers = [Beer]()
  
  private var db = Firestore.firestore()
  
  func getBeersData() {
    db.collection("beers").getDocuments {
      querySnapshot, error in
          guard let documents = querySnapshot?.documents else {
                print("No documents! \(error!)")
                return
            }
          for documentSnapshot in documents {
            let data = documentSnapshot.data()
            let name = data["Name"] as? String ?? ""
            let abv = data["ABV"] as? Int ?? 0
            let sour = data["Sour"] as? Int ?? 0
            let astring = data["Astringency"] as? Int ?? 0
            let key = data["key"] as? Int ?? 0
            let style = data["Style"] as? String ?? ""
            let malty = data["Malty"] as? Int ?? 0
            let alcohol = data["Alcohol"] as? Int ?? 0
            let bitter = data["Bitter"] as? Int ?? 0
            let avgR = data["Ave Rating"] as? Double ?? 0.0
            let description = data["Description"] as? String ?? ""
            let fruits = data["Fruits"] as? Int ?? 0
            let spices = data["Spices"] as? Int ?? 0
            let hoppy = data["Hoppy"] as? Int ?? 0
            let sweet = data["Sweet"] as? Int ?? 0
            let salty = data["Salty"] as? Int ?? 0
            
            let b1 = Beer(abv: abv, sour: sour, astring: astring, key: key, style: style, malty: malty, alcohol: alcohol, bitter: bitter, avgRating: avgR, description: description, name: name, fruits: fruits, spices: spices, hoppy: hoppy, sweet: sweet, salty: salty)
            self.beers.append(b1)
//            print("ABV of Beer 1: \(b1.abv)")
//            print("Alcohol rate of Beer 1: \(b1.alcohol)")
//            print("Name of Beer 1: \(b1.name)")
//            print("Avg Rating of Beer 1: \(b1.avgRating)")
//            print("Test printing of Beer 1 Done. Breaking out!")
//            break
          }
    }
  }

  var UserTags = ["Malty","Salty"]

  func getRandomBeers(tags: [String]? = nil) {
    var inputTags = tags
    if tags != nil {
      inputTags?.shuffle()
      let firstTag = inputTags![0]
      db.collection("beers").getDocuments {
        querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                  print("No documents! \(error!)")
                  //completion(nil)
                  return
              }
            for documentSnapshot in documents {
              let data = documentSnapshot.data()
              if data[firstTag] as! Int > 50 {
                let name = data["Name"] as? String ?? ""
                let abv = data["ABV"] as? Int ?? 0
                let sour = data["Sour"] as? Int ?? 0
                let astring = data["Astringency"] as? Int ?? 0
                let key = data["key"] as? Int ?? 0
                let style = data["Style"] as? String ?? ""
                let malty = data["Malty"] as? Int ?? 0
                let alcohol = data["Alcohol"] as? Int ?? 0
                let bitter = data["Bitter"] as? Int ?? 0
                let avgR = data["Ave Rating"] as? Double ?? 0.0
                let description = data["Description"] as? String ?? ""
                let fruits = data["Fruits"] as? Int ?? 0
                let spices = data["Spices"] as? Int ?? 0
                let hoppy = data["Hoppy"] as? Int ?? 0
                let sweet = data["Sweet"] as? Int ?? 0
                let salty = data["Salty"] as? Int ?? 0
                
                let b2 = Beer(abv: abv, sour: sour, astring: astring, key: key, style: style, malty: malty, alcohol: alcohol, bitter: bitter, avgRating: avgR, description: description, name: name, fruits: fruits, spices: spices, hoppy: hoppy, sweet: sweet, salty: salty)
                self.beers.append(b2)
//                print("ABV of Recommended Beer 1: \(b2.abv)")
//                print("Alcohol rate of Recommended Beer 1: \(b2.alcohol)")
//                print("Name of Recommended Beer 1: \(b2.name)")
//                print("Avg Rating of Recommended Beer 1: \(b2.avgRating)")
//                print("Test printing of Recommended Beer 1 Done. Breaking out!")
//                break
              }
              
          }
      }
      
    } else {
      //give Random beers
      getBeersData()
    }
  }

}


//
//  BeersViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class BeersViewModel: ObservableObject {
  @Published var beers = [Beer]()
  //@Published var randomBeers = [Card]()
  @Published var beerDetails = Product()
  @ObservedObject var imgExt = ImageViewModel()
  @Published var beerImg = ""
  var x: CGFloat = 0.0
  var y: CGFloat = 0.0
  var degree: Double = 0.0
  private var db = Firestore.firestore()
  var resname = ""
  
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
            let abv = data["ABV"] as? Double ?? 0.0
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

  //var UserTags = ["Malty","Salty"]

  func getRandomBeers(tags: [String]? = nil, completion: @escaping(([Card]) -> ())) {
    var brlist = [Card]()
    var inputTags = tags
    let myGroup = DispatchGroup()
    myGroup.enter()
    if tags != nil {
      inputTags?.shuffle()
      let usrNope = UserDefaults.standard.object(forKey: "nope") as! [String]
      print("RANDOM????-----------")
      print(usrNope)
      let firstTag = inputTags![0]
      print(firstTag)
      if usrNope.isEmpty == false {
          myGroup.enter()
          print("AM I NINININININININ")
          db.collection("beers").whereField("Style", isEqualTo: firstTag).getDocuments {
            querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                      print("No documents! \(error!)")
                      //completion(nil)
                      return
                  }
                var cnt = 0
                for documentSnapshot in documents {
                    if cnt == 10 { break }
                    let data = documentSnapshot.data()
                    let name = data["Name"] as? String ?? ""
                    if usrNope.contains(name) == false {
                        print("NO LONGER IN HERE!!!!!")
                        print(cnt)
                        cnt += 1
                        let abv = data["ABV"] as? Double ?? 0.0
                        let avgR = data["Ave Rating"] as? Double ?? 0.0
                        print("BEER ORIGINAL NAME?")
                        print(name)
                        self.imgExt.getImage(beer: name, completion: { (success) -> Void in
                          if success == true {
                              let b2 = Card(name: self.imgExt.itemName, fakeName: name, imageName: self.imgExt.imgURL, avgRating: avgR, alc: abv)
                                //print(self.randomBeers)
                                brlist.append(b2)
                          }
                        })
                    }
                    
                  
              }
              myGroup.leave()
          }
      } else {
          myGroup.enter()
          db.collection("beers").whereField("Style", isEqualTo: firstTag).getDocuments {
            querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                      print("No documents! \(error!)")
                      //completion(nil)
                      return
                  }
                var cnt = 0
                for documentSnapshot in documents {
                  cnt += 1
                    if cnt == 10 {
                        break
                    }
                  let data = documentSnapshot.data()
                  var name = data["Name"] as? String ?? ""
                  let abv = data["ABV"] as? Double ?? 0.0
                  let avgR = data["Ave Rating"] as? Double ?? 0.0
                  print("BEER ORIGINAL NAME?")
                  print(name)
                  self.imgExt.getImage(beer: name, completion: { (success) -> Void in
                      print(success)
                      print("DID THIS WORKKKKKKKKKKK")
                    if success == true {
                      let b2 = Card(name: self.imgExt.itemName, fakeName: name, imageName: self.imgExt.imgURL, avgRating: avgR, alc: abv)
                      brlist.append(b2)
                    }
                  })
              }
              myGroup.leave()
          }
      }
        
    myGroup.leave()
    } else {
      //give Random beers
      getBeersData()
      myGroup.leave()
    }
      myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
          brlist.shuffle()
          print("AFTER GETTING RANDOM BEERS")
          print(brlist)
          completion(brlist)
      }
  }
  
    func getBeerDetail(name: String, fakeName: String, completion: @escaping((Bool) -> ())) {
    let myGroup = DispatchGroup()
    myGroup.enter()
    let beerRef = self.db.collection("beers").document(name)
    beerRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let alc = data?["ABV"] as? Double ?? 0.0
            let style = data?["Style"] as? String ?? ""
            let brew = data?["Brewery"] as? String ?? ""
            let avgRating = data?["Ave Rating"] as? Double ?? 0.0
            let sour = data?["Sour"] as? Int ?? 0
            let bitter = data?["Bitter"] as? Int ?? 0
            let sweet = data?["Sweet"] as? Int ?? 0
            let fruity = data?["Fruits"] as? Int ?? 0
            print("%%%%%%%%%%%%%%%%%%%%%%%%")
            print(name)
              self.beerDetails = Product(name: name, fakeName: fakeName, image: "", avgRating: avgRating, alc: alc, brewery: brew, style: style, sweet: sweet, sour: sour, bitter: bitter, fruits: fruity)
            print(self.beerDetails.avgRating)
          }
          catch {
            print(error)
          }
        }
      }
    myGroup.leave()
    }
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
      completion(true)
    }
  }

  func load(barcode: String, completion: @escaping((Bool) -> ())) {
    var arr = Array(barcode)
    var realbar = barcode
    var sub1 = ""
    if barcode.count == 8 {
      var seventh = arr[6]
      if ["0","1","2"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 3])
        sub1 += String(seventh) + "0000"
        sub1 += String(arr[3 ..< 6])
        sub1 += String(arr[7])
      }
      if ["3"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 4])
        sub1 += "00000"
        sub1 += String(arr[4 ..< 6])
        sub1 += String(arr[7])
      }
      if ["4"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 5])
        sub1 += "00000"
        sub1 += String(arr[5 ..< 6])
        sub1 += String(arr[7])
      }
      if ["5","6","7","8","9"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 6])
        sub1 += "0000" + String(seventh)
        sub1 += String(arr[7])
      }
    }

    print(sub1)
    if sub1 != "" {
      realbar = sub1
    }
   let url = "https://buycott.com/api/v4/products/lookup?barcode=\(realbar)&access_token=njpTtmc5if7vMhCXL4jGBqQ48fL9mxh_OSY-E3Wp"
   let sem = DispatchSemaphore(value: 0)
   let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
     defer { sem.signal() }
     guard let data = data else {
       print("Error: No data to decode")
       return
     }
     guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
       print("Error: Couldn't decode data into a result")
       return
     }
     self.resname = result.products[0].name
     print("ARE U THERE PLZZZZZZ")
     print(self.resname)
//   for p in result.products {
//     print(p.name)
//     myGroup.enter()
//     self.imgExt.getImage(beer: p.name, completion: { (success) -> Void in
//       print("+==============")
//       print(success)
//       if success {
//         DispatchQueue.main.async {
//           print("SHIBAL")
//           print(self.imgExt.imgURL)
//           self.beerImg = self.imgExt.imgURL
//         }
//         //self.beerImg = self.imgExt.imgURL
//
//         self.getBeerDetail(name: self.imgExt.itemName)
//       }
//     })
//     myGroup.leave()
//     break
//   }
    }
    task.resume()
    sem.wait(timeout: .distantFuture)
    self.imgExt.getImage(beer: self.resname, completion: { (success) -> Void in
    print("+==============")
    print(success)
     if success {
       DispatchQueue.main.async {
         print("SHIBAL")
         print(self.imgExt.imgURL)
         self.beerImg = self.imgExt.imgURL
           self.getBeerDetail(name: self.imgExt.itemName, fakeName: self.resname, completion: { (success) -> Void in
           print("+==============")
           print(success)
           completion(true)
         })
       }
       //self.beerImg = self.imgExt.imgURL
         
     }
   })


 }
}

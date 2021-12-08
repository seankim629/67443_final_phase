//
//  File.swift
//  Cheers_v1
//
//  Created by JP Park on 12/3/21.
//

import Foundation
import SwiftSoup

class ImageViewModel: ObservableObject {
    @Published var imgURL: String = ""
    @Published var itemName: String = ""
        
  func getImage(beer: String, completion: @escaping((Bool) -> ())) {
        let myGroup = DispatchGroup()
        print("WHATS NEXT?")
        print(beer)
        var imgurl: String = ""
        var name: String = ""
        var beerArr = beer.components(separatedBy: " ")
        print(beerArr)
        print("WHAT THE FUCCKCCKCKCKCKCKCKCKCKC")
        var conv = beerArr.joined(separator: "%20")
        print(conv)
        let url = URL(string:"https://drizly.com/search?q=\(conv)")!
        myGroup.enter()
        do {
            let html = try String(contentsOf: url)
            let doc: Document = try SwiftSoup.parse(html)
            let allscripts = try doc.getElementsByTag("script")
            
            var wantedscript = try doc.getElementsByTag("script")[17].html()
            
            if allscripts.count == 31 {
                print("IT SHOULD COME IN HERE")
                wantedscript = try doc.getElementsByTag("script")[18].html()
            }
            
            let newScript = wantedscript.dropFirst(4).dropLast(3)
            
            let data = Data(newScript.utf8)

            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a string array
                    if let outer = json["catalogItems"] as? NSArray
                    {
                        print("I am printing the number of catalog items here")
                        print(outer.count)
                        if outer.count != 0 {
                            if let first = outer[0] as? NSDictionary {
                                if let title = first["catalogItem"] as? NSDictionary {
                                    name = title["itemName"] as? String ?? ""
                                    //print(title["itemName"] as? String)
                                }
                                imgurl = first["imgSrc"] as? String ?? ""
                                //print(first["imgSrc"] as? String)
                            }
    //                        print(itemName[0])
                        }
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            print("How Mang Scripts?")
            print(allscripts.count)
            print("+++++++++++++")

            print(itemName)
            print("+++++++++++++")
            print(imgURL)
            print(try doc.title())
//            print(try allscripts.count)
//            print(try type(of: data))
        
        myGroup.leave()
        } catch Exception.Error(let type, let message) {
            print("oh no")
            myGroup.leave()
        } catch {
            print("oh no2")
            myGroup.leave()
        }
      myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
        print(imgurl)
        print("!?!?!?!?!?!?!?!")
        print(name)
        self.imgURL = imgurl
        self.itemName = name
          if self.imgURL == "" || self.itemName == "" {
              completion(false)
          } else {
              completion(true)
          }
      }
    }
}

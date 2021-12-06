//
//  File.swift
//  Cheers_v1
//
//  Created by JP Park on 12/3/21.
//

import Foundation
import SwiftSoup

class ImageViewModel: ObservableObject {
    let url = URL(string:"https://drizly.com/search?q=blue%20moon")!
    
    var imgURL: String = ""
    var itemName: String = ""
        
    func getImage() {
        
        do {
            let html = try String(contentsOf: url)
            let doc: Document = try SwiftSoup.parse(html)
            let allscripts = try doc.getElementsByTag("script")
            var wantedscript = try doc.getElementsByTag("script")[17].html()
            
            let newScript = wantedscript.dropFirst(4).dropLast(3)
            
            let data = Data(newScript.utf8)

            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a string array
                    if let outer = json["catalogItems"] as? NSArray
                    {
                        if let first = outer[0] as? NSDictionary {
                            if let title = first["catalogItem"] as? NSDictionary {
                                itemName = title["itemName"] as? String ?? ""
                                //print(title["itemName"] as? String)
                            }
                            imgURL = first["imgSrc"] as? String ?? ""
                            //print(first["imgSrc"] as? String)
                        }
//                        print(itemName[0])
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
            
        } catch Exception.Error(let type, let message) {
            print("oh no")
        } catch {
            print("oh no2")
        }
        
    }
}

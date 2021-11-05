//
//  ContentView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 10/28/21.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @ObservedObject var obs = observer(barcode: "038766301208")
    var body: some View {
        //RatingsListView()
        WishesListView()
        Text("Hello world!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer : ObservableObject {
//  @Published var datas = [Product]()
  
  init(barcode: String) {
    let url = "https://buycott.com/api/v4/products/lookup?barcode=\(barcode)&access_token=qeqwI-4DPMJeAm2rBUrwTzgNA1aF3fCjb2r2rmEb"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
        print("Error: Couldn't decode data into a result")
        return
    }
    for p in result.products {
      print(p.name)
      print(p.image)
    }
  }
  task.resume()
}

  
}

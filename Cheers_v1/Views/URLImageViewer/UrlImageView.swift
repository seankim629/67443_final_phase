//
//  UrlImageView.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/04.
//

import Foundation
import SwiftUI

// profile image box
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct ProductImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image("beer_placeholder")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct CustomImageView: View {
  let urlString: String?

  var body: some View {
    if let url = URL(string:urlString!),
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40)
        .padding(.all, 15)
    } else {
      Image("beer_placeholder")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40)
        .padding(.all, 15)
    }
  }
}



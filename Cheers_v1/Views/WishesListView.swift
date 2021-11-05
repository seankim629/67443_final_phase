//
//  WishesListView.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/04.
//

import Foundation
import SwiftUI

struct WishesListView: View {
  @ObservedObject private var viewModel = WishesViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.wishes) { wish in
        VStack(alignment: .leading) {
          WishlistCard(image: CustomImageView(urlString: "https://i5.walmartimages.com/asr/74caf649-c98a-42d0-b3e6-e17a8708d5f2_1.29daddebeeed3560d7fdc661e8cd7702.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF"), beer: wish.product, type: wish.style, alcohol: wish.alc, rating:wish.rowRating)
//          Text(wish.product)
//            .font(.headline)
//          Text("Avg Rating is \(wish.rowRating)")
//            .font(.subheadline)
//          Text("Alcohol Rate is \(wish.alc)%")
//            .font(.subheadline)
//          Text("Beer type is \(wish.style)")
//            .font(.subheadline)
//          CustomImageView(urlString: "https://i5.walmartimages.com/asr/74caf649-c98a-42d0-b3e6-e17a8708d5f2_1.29daddebeeed3560d7fdc661e8cd7702.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF")

        }
      }
      .navigationBarTitle("Wishes")
      .onAppear() {
        self.viewModel.testGetWishList()
      }
    }
  }
  
}

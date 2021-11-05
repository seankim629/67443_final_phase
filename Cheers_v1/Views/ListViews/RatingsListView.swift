//
//  RatingsListView.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import SwiftUI

struct RatingsListView: View {
  @ObservedObject private var viewModel = RatingsViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.ratings) { rating in
        VStack(alignment: .leading) {
          Text(rating.product)
            .font(.headline)
          Text("My Rating is \(rating.rowRating)")
            .font(.subheadline)
          Text("Alcohol Rate is \(rating.alc)%")
            .font(.subheadline)
          Text("Beer type is \(rating.style)")
            .font(.subheadline)
        }
      }
      .navigationBarTitle("Ratings")
      .onAppear() {
        self.viewModel.testGetRatingList()
      }
    }
  }
  
}

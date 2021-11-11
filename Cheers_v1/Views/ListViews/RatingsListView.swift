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
      VStack {
          HStack{
              Text("My Ratings")
                  .frame(alignment: .leading)
                  .font(.system(size: 28, weight: .bold, design: .default))
                  .foregroundColor(.black)
                  .padding(15)
              Spacer()
          }
          List(viewModel.ratings) { rating in
            VStack(alignment: .leading) {
              RatingCard(image: CustomImageView(urlString: "https://i5.walmartimages.com/asr/74caf649-c98a-42d0-b3e6-e17a8708d5f2_1.29daddebeeed3560d7fdc661e8cd7702.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF"), beer: rating.product, type: rating.style, alcohol: Int(rating.alc), rating:rating.rowRating, date:rating.dateString)
            }
          } .onAppear() {
              self.viewModel.ratings = [RatingRow]()
              self.viewModel.testGetRatingList()
            }
      }

  }
  
}

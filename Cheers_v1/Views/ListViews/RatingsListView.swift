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
      VStack (alignment: .leading) {          
          HStack{
              Image(systemName: "star.fill").foregroundColor(Color("Highlight Color"))
                  .font(.system(size: 28))
              Text("My Ratings")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Background Color"))
          }.frame(maxWidth:.infinity, maxHeight:25, alignment: .topLeading)
              .padding(.top, 20)
              .padding(.leading, 28)
          
          List(viewModel.ratings.reversed()) { rating in
            VStack(alignment: .leading) {
              ZStack{
                NavigationLink(destination: CardDetailScreen(beerName: rating.product, beerPhoto: rating.rowPhoto)) {
                  EmptyView()
                }.opacity(0.0).buttonStyle(PlainButtonStyle())
                RatingCard(image: CustomImageView(urlString: rating.rowPhoto), beer: rating.product, type: rating.style, alcohol: Int(rating.alc), rating:rating.rowRating, date:rating.dateString)
              }
              
              
//              NavigationLink(destination: CardDetailScreen(beerName: rating.product, beerPhoto: rating.rowPhoto)) {
//                RatingCard(image: CustomImageView(urlString: rating.rowPhoto), beer: rating.product, type: rating.style, alcohol: Int(rating.alc), rating:rating.rowRating, date:rating.dateString)
//              }
            }
          } .onAppear() {
              self.viewModel.ratings = [RatingRow]()
              self.viewModel.testGetRatingList()
            }
      }

  }
  
}

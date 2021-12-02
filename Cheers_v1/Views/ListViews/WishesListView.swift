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

//    func initialize(){
//            UITableView.appearance().backgroundColor = .clear
//            UITableViewCell.appearance().backgroundColor = .clear
//            UITableView.appearance().tableFooterView = UIView()
//     }
    
  var body: some View {
      VStack (alignment: .leading) {
          HStack{
              Image(systemName: "bookmark.fill").foregroundColor(Color("Highlight Color"))
                  .font(.system(size: 28))
              Text("My Wishlist")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Background Color"))
          }.frame(maxWidth:.infinity, maxHeight:25, alignment: .topLeading)
              .padding(.top, 20)
              .padding(.leading, 28)
                    
          List(viewModel.wishes) { wish in
            VStack(alignment: .leading) {
              WishlistCard(image: CustomImageView(urlString: "https://i5.walmartimages.com/asr/74caf649-c98a-42d0-b3e6-e17a8708d5f2_1.29daddebeeed3560d7fdc661e8cd7702.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF"), beer: wish.product, type: wish.style, alcohol: Int(wish.alc), rating:wish.rowRating)
            }
          } .onAppear() {
              self.viewModel.wishes = [WishRow]()
              self.viewModel.testGetWishList()
            }
      }
     
  }
  
}

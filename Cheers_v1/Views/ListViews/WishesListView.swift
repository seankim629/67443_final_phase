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
  @State var localWishes = [WishRow]()
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
                    
        List(self.localWishes.reversed()) { wish in
            VStack(alignment: .leading) {
              ZStack{
                NavigationLink(destination: CardDetailScreen(beerName: wish.product, beerPhoto: wish.rowPhoto))
               {
                EmptyView()
              }.opacity(0.0).buttonStyle(PlainButtonStyle())
                WishlistCard(image: CustomImageView(urlString: wish.rowPhoto), beer: wish.product, type: wish.style, alcohol: Int(wish.alc), rating:wish.rowRating)
              }
              
//              NavigationLink(destination: CardDetailScreen(beerName: wish.product, beerPhoto: wish.rowPhoto)) {
//                  WishlistCard(image: CustomImageView(urlString: wish.rowPhoto), beer: wish.product, type: wish.style, alcohol: Int(wish.alc), rating:wish.rowRating)
//              }
            }
          } .onAppear() {
              //self.viewModel.wishes = [WishRow]()
              self.viewModel.testGetWishList(completion: { (listed) -> Void in
                self.localWishes = listed
              })
            }
      }
     
  }
  
}

//
//  ProfileView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct ProfileView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
     }
    
    var body: some View {
        VStack {
            
                VStack{
                    NavigationLink(destination: WishesListView()) {
                        HStack(spacing: 170) {
                            Text("My Wishlist")
                            .font(.callout)

                            Image(systemName: "arrow.right")
                        }
                        .padding(.vertical, 10)
                        .padding(.leading, 22)
                        .padding(.trailing, 13)
                        .frame(width: 319, height: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 4)
                        .frame(width: 319, height: 44)
                    }.padding(.bottom)
                    NavigationLink(destination: RatingsListView()) {
                        HStack(spacing: 170) {
                            Text("My Ratings")
                            .font(.callout)

                            Image(systemName: "arrow.right")
                        }
                        .padding(.vertical, 10)
                        .padding(.leading, 22)
                        .padding(.trailing, 13)
                        .frame(width: 319, height: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 4)
                        .frame(width: 319, height: 44)
                    }
                
            }
        }.navigationTitle("Profile").navigationBarTitleDisplayMode(.inline)
            
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

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
        VStack (alignment: .leading) {
            HStack{
                Image(systemName: "person.fill").foregroundColor(Color("Highlight Color"))
                    .font(.system(size: 28))
                Text("Profile")
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(Color("Background Color"))
            }
            .padding(.bottom, 25)

            
            
                VStack{
                    NavigationLink(destination: WishesListView()) {
                        HStack(spacing: 170) {
                            Text("My Wishlist")
                            .font(.callout)
                            .foregroundColor(Color("Background Color"))

                            Image(systemName: "arrow.right") .foregroundColor(Color("Background Color"))
                        }
                        .padding(.vertical, 10)
                        .padding(.leading, 17)
                        .padding(.trailing, 13)
                        .frame(width: 335, height: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 4)
                        .frame(width: 335, height: 44)
                    }.padding(.bottom)
                    
                    NavigationLink(destination: RatingsListView()) {
                        HStack(spacing: 170) {
                            Text("My Ratings")
                            .font(.callout) .foregroundColor(Color("Background Color"))

                            Image(systemName: "arrow.right") .foregroundColor(Color("Background Color"))
                        }
                        .padding(.vertical, 10)
                        .padding(.leading, 17)
                        .padding(.trailing, 13)
                        .frame(width: 335, height: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 4)
                        .frame(width: 335, height: 44)
                    }
                
            }
            
        }.navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Image("header").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                    Text("Cheers").fontWeight(.bold).foregroundColor(.white)}
            }
        }
        
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)
            .padding(.top, 20)
            .padding(.leading, 28)
        
            
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

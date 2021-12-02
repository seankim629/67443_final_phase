//
//  ProfileView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

struct ProfileView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
     }
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @ObservedObject var usr = UsersViewModel()
    private let user = GIDSignIn.sharedInstance()!.currentUser
    
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
            
            HStack {
              let _ = print(type(of: user?.profile.imageURL(withDimension: 200).absoluteString))
                      NetworkImage(url: user?.profile.imageURL(withDimension: 200))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(8)

                      VStack(alignment: .leading) {
                        Text(user?.profile.name ?? "")
                          .font(.headline)

                        Text(user?.profile.email ?? "")
                          .font(.subheadline)
                      }

                      Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding()

                    Spacer()

            
            
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
            
            //move to top
            Button("Sign out") {
              viewModel.signOut()

            }
            .buttonStyle(AuthenticationButtonStyle())
            
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

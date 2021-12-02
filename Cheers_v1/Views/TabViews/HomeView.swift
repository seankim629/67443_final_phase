//
//  HomeView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var rating: Double = 4.5
    @ObservedObject var usr = UsersViewModel()

  private let user = GIDSignIn.sharedInstance()!.currentUser
    
    var body: some View {
        VStack {
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

        }.navigationTitle("Home").navigationBarTitleDisplayMode(.inline)
              .onAppear {
                if(UserDefaults.standard.bool(forKey: "homeTeamName") == false) {
                  usr.checkUser(email: user?.profile.email ?? "", name: user?.profile.name ?? "", photo: (user?.profile.imageURL(withDimension: 200).absoluteString)!)
                }
              }
    }
}

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

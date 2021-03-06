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
    @State private var rating: Double = 4.5
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @ObservedObject var usr = UsersViewModel()
    @ObservedObject var br = BeersViewModel()
    private let user = GIDSignIn.sharedInstance()!.currentUser
    @State var isShown = false
    @State private var isLoading = false
    @State var randoms = [Card]()
  
    func startNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          if(UserDefaults.standard.bool(forKey: "homeTeamName") == false) {
                    print(self.user)
                    let user = GIDSignIn.sharedInstance()!.currentUser
                    print(user)
                    if user != nil {
                      usr.checkUser(email: user?.profile.email ?? "", name: user?.profile.name ?? "", photo: (user?.profile.imageURL(withDimension: 200).absoluteString) as? String ?? "", completion: { (success) -> Void in
                            let prefs = UserDefaults.standard.object(forKey: "pref")!
                            self.br.getRandomBeers(tags: prefs as! [String], completion: { (randoms) -> Void in
                                self.randoms = randoms
                                self.isLoading = false
                            })
                          })
                    }
          } else {
          let prefs = UserDefaults.standard.object(forKey: "pref")!
          self.br.getRandomBeers(tags: prefs as! [String], completion: { (randoms) -> Void in
              self.randoms = randoms
              self.isLoading = false
          })
        }
      }

    }
    var body: some View {
      ZStack {
        if isLoading {
                    ZStack {
                      Color(.systemBackground)
                        .ignoresSafeArea()
                    }
                    ProgressView()
                      .progressViewStyle(CircularProgressViewStyle(tint: Color("Highlight Color")))
                      .scaleEffect(3)
        } else {
        VStack(alignment: .leading) {
              HStack{
                  Image(systemName: "lightbulb.fill").foregroundColor(Color("Highlight Color"))
                      .font(.system(size: 26))
                  Text("Discover Beers")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Background Color"))
              }.padding(.bottom, 5)
                  .padding(.top, 20)
                  .padding(.leading, 28)
              

            CardsSection(beerlist: self.$randoms)
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
        .onAppear {
            startNetworkCall()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

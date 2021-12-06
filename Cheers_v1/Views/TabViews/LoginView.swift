//
//  LoginView.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/12/01.
//
import SwiftUI

struct LoginView: View {

  // 1
  @ObservedObject var img = ImageViewModel()
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @Binding var selectedTab: Tab
  var body: some View {
      ZStack{
          Color("Background Color")
          VStack {
            Spacer()
              
            Image("splash").resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: 200)


            Spacer()

            Button("Sign in with Google") {
              viewModel.signIn()
              selectedTab = .home
            }
            .buttonStyle(AuthenticationButtonStyle())
            .padding(.bottom, 20)
          }
      }.ignoresSafeArea()
//          .onAppear(perform: {img.getImage()})
    
      
  }
}

// 4
struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(Font.body.weight(.semibold))
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color("Highlight Color"))
      .cornerRadius(12)
      .padding()
  }
}

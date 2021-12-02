//
//  LoginView.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/12/01.
//
import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @Binding var selectedTab: Tab
  var body: some View {
    VStack {
      Spacer()

      // 2
      Text("Welcome to Ellifit!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Text("Empower your elliptical workouts by tracking every move.")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()

      Spacer()

      // 3
      Button("Sign in with Google") {
        viewModel.signIn()
        selectedTab = .home
      }
      .buttonStyle(AuthenticationButtonStyle())
    }
  }
}

// 4
struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemIndigo))
      .cornerRadius(12)
      .padding()
  }
}

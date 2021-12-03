//
//  AuthenticationViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/30.
//
import Firebase
import GoogleSignIn
import Combine
import Foundation

class AuthenticationViewModel: NSObject, ObservableObject {


  enum SignInState {
    case signedIn
    case signedOut
  }

  @Published var state: SignInState = .signedOut

  override init() {
    super.init()
    setupGoogleSignIn()
  }

  // 4
  func signIn() {
    if GIDSignIn.sharedInstance().currentUser == nil {
      GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
      GIDSignIn.sharedInstance().signIn()
    }
  }

  // 5
  func signOut() {
    GIDSignIn.sharedInstance().signOut()

    do {
      try Auth.auth().signOut()

      state = .signedOut
      UserDefaults.standard.set(nil, forKey: "uid")
      UserDefaults.standard.set(nil, forKey: "ratingid")
      UserDefaults.standard.set(nil, forKey: "ratingcnt")
      UserDefaults.standard.set(false, forKey: "homeTeamName")
    } catch let signOutError as NSError {
      print(signOutError.localizedDescription)
    }
  }

  // 6
  private func setupGoogleSignIn() {
    GIDSignIn.sharedInstance().delegate = self
    let user = GIDSignIn.sharedInstance()!.currentUser
    if (user == nil) && (GIDSignIn.sharedInstance().hasPreviousSignIn()) {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        state = .signedIn
    }
  }
}

extension AuthenticationViewModel: GIDSignInDelegate {

  // 1
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error == nil {
      print(user)
      firebaseAuthentication(withUser: user)
    } else {
      print("WHAT IS WRONG?")
      print(error.debugDescription)
    }
  }

  // 2
  private func firebaseAuthentication(withUser user: GIDGoogleUser) {
    if let authentication = user.authentication {
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

      Auth.auth().signIn(with: credential) { (_, error) in
        if let error = error {
          print("NOT WHERERERERE")
          print(error.localizedDescription)
        } else {
          print("WORKS FINE!!!!!!")
          self.state = .signedIn
        }
      }
    }
  }
}

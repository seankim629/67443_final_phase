//
//  HomeView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct HomeView: View {
    @State private var rating: Double = 4.5
    var body: some View {
        VStack {
//            Text("Content")
          //StarSlider($rating)
        }.navigationTitle("Home").navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

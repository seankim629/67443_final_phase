//
//  FeedView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack {
            Text("Content")
        }.navigationTitle("Feed").navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

//
//  SearchView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack {
            DetailScreen()
        }.navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

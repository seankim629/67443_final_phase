//
//  SearchView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "magnifyingglass").foregroundColor(Color("Highlight Color"))
                    .font(.system(size: 28))
                Text("Search Beers")
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(Color("Background Color"))
            }.padding(.bottom, 40)
            
            
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

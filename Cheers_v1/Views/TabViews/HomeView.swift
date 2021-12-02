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
            

            CardsSection()
        }.navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Image("header").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                    Text("Cheers").fontWeight(.bold).foregroundColor(.white)}
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  FeedView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Image(systemName: "text.bubble.fill").foregroundColor(Color("Highlight Color"))
                    .font(.system(size: 28))
                Text("Feed")
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

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

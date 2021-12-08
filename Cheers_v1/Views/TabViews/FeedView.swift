//
//  FeedView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//
//
//  FeedView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct FeedView: View {
    
    var feed: [FeedItem] =  [.demo, .demo2, .demo3]
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack (alignment: .leading){
                    HStack{
                        Image(systemName: "text.bubble.fill").foregroundColor(Color("Highlight Color"))
                            .font(.system(size: 28))
                        Text("Feed")
                              .font(.title)
                              .fontWeight(.bold)
                              .foregroundColor(Color("Background Color"))
                    }.padding(.bottom, 20)
                        .padding(.top, 20)
                        .padding(.leading, 28)
                    ForEach(feed) { item in
                        FeedTileView(feedItem: item)
                            .padding()
                    }
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Image("header").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                    Text("Cheers").fontWeight(.bold).foregroundColor(.white)}
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)
            
    }
}

struct FeedItem: Identifiable {
    var id = UUID()
    
    let name: String
    let date: Int
    let rating: String
    let beer: String
    
    static var demo: FeedItem {
        return FeedItem(name: "Sean Kim", date: 2, rating: "4.2", beer: "Moosehead")
    }
    static var demo2: FeedItem {
        return FeedItem(name: "JP Park", date: 5, rating: "3.4", beer: "Budweiser")
    }
    static var demo3: FeedItem {
        return FeedItem(name: "Soo Kim", date: 12, rating: "4.5", beer: "BrooklynLager")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feed: [.demo, .demo2, .demo3])
    }
}

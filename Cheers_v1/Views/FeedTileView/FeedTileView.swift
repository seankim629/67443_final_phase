//
//  FeedTileView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 12/2/21.
//

import SwiftUI

struct FeedTileView: View {
    var feedItem: FeedItem
    
   
    var body: some View {
        VStack {
            HStack {
                avatar
                VStack(alignment: .leading) {
                    HStack{
                        Text(feedItem.name)
                            .foregroundColor(Color("Highlight Color"))
                        Text(" rated a beer")
                        Text(feedItem.rating)
                            .foregroundColor(Color("Highlight Color"))
                    }
                    Text(String(feedItem.date) + " days ago")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
            .padding([.top])
            
//            if let imageUrl = feedItem.imageUrl {
            Image(feedItem.beer).resizable().scaledToFit()
//            }
            
            footer
            
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
    }
    
    var avatar: some View {
        AsyncImage(url: nil) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "person.circle.fill")
              .resizable()
              .aspectRatio(contentMode: .fit)
        }
        .frame(width: 50, height: 50)
        .cornerRadius(25)
    }
    
    
    
    var footer: some View {
        HStack {
//            Group {
                Image(systemName: "bubble.left.fill").foregroundColor(Color("Highlight Color"))
                Text("12")
                Image(systemName: "heart.fill").foregroundColor(Color("Highlight Color"))
                Text("18")
                Image(systemName: "paperplane.fill").foregroundColor(Color("Highlight Color"))
                Text("3")
                Spacer()
                Image(systemName: "bookmark.fill").foregroundColor(Color("Highlight Color"))
//            }
//            .foregroundColor(Color("Highlight Color"))
        }
        .padding(2)
       
    }
}

//struct FeedTileView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedTileView()
//    }
//}

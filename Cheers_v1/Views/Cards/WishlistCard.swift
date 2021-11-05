//
//  Wishlist.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI

struct WishlistCard: View {
    
    var image: CustomImageView
    var beer: String
    var type: String
    var alcohol: Int
    var rating: Double
    
    var body: some View {
        HStack(alignment: .center) {
            image
            VStack(alignment: .leading) {
                Text(beer)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.black)
                
                HStack() {
                    Text(type)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text(" | ").foregroundColor(.gray)
                    Text(String.init(alcohol)+"%")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                }
    
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "star.fill").foregroundColor(Color("Highlight Color"))
                    Text(String.init(format: "%0.1f", rating))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 3)
                        .padding(.bottom, 1)
                }
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.white)
        .modifier(CardModifier())
        .padding(.all, 10)
        
    }
}




struct WishlistCard_Previews: PreviewProvider {
    static var previews: some View {
        WishlistCard(image: CustomImageView(urlString: "https://firebasestorage.googleapis.com/v0/b/cheers-4b4f6.appspot.com/o/profile_images%2Fcarlsberg.png?alt=media&token=261d7cd0-3292-4577-ab54-0d53cd7a0dc6"), beer: "Carlsberg", type: "Lager", alcohol: 5, rating: 4.2)
    }
}

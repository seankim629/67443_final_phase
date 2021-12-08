//
//  RatingCard.swift
//  figmatest
//
//  Created by JP Park on 11/4/21.
//

import SwiftUI


struct RatingCard: View {
    
    var image: CustomImageView
    var beer: String
    var type: String
    var alcohol: Int
    var rating: Double
    var date: String
    
    var body: some View {
        HStack(alignment: .center) {
            image
            VStack(alignment: .leading, spacing:0) {
                Text(beer)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                HStack() {
                    Text(type)
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text(" | ").font(.system(size: 12, weight: .bold, design: .default)).foregroundColor(.gray)
                    Text(String.init(alcohol)+"%")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                }.padding(.top, 2)
    
                HStack(alignment: .lastTextBaseline, spacing:0) {
                    Image(systemName: "star.fill").foregroundColor(Color("Highlight Color"))
                        .font(.system(size: 12))
                        .padding(.trailing, 3)
                    Text(String.init(format: "%0.1f", rating))
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .padding(.trailing, 8)
                        .foregroundColor(.black)
                    Text(date).font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                }.padding(.top, 10)
            }.padding(.trailing, 20)
                .padding(.bottom, 10)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            Color.white
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
            )
        .padding(.all, 2)
        
    }
}




//struct RatingCard_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingCard(image: CustomImageView(urlString: "https://firebasestorage.googleapis.com/v0/b/cheers-4b4f6.appspot.com/o/profile_images%2Fcarlsberg.png?alt=media&token=261d7cd0-3292-4577-ab54-0d53cd7a0dc6"), beer: "Carlsberg", type: "Lager", alcohol: 5, rating: 4.2, date:"10/01/21")
//    }
//}

//
//  RatingCard.swift
//  figmatest
//
//  Created by JP Park on 11/4/21.
//

import SwiftUI


struct RatingCard: View {
    
    var image: String
    var beer: String
    var type: String
    var alcohol: String
    var rating: Double
    var date: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32)
                .padding(.all, 20)
            
            VStack(alignment: .leading) {
                Text(beer)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.black)
                
                HStack() {
                    Text(type)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text(" | ").foregroundColor(.gray)
                    Text(alcohol)
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
                    Text(date).font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .padding(.top, 3)
                        .padding(.bottom, 1)
                        .padding(.leading, 100)
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




struct RatingCard_Previews: PreviewProvider {
    static var previews: some View {
        RatingCard(image: "Beer", beer: "Carlsberg", type: "Lager", alcohol: "5%", rating: 4.2, date: "10/01/2021")
    }
}

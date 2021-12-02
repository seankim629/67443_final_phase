//
//  CardsSection.swift
//  Cheers_v1
//
//  Created by JP Park on 11/30/21.
//

import SwiftUI

struct CardsSection: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Have you tried any beers on the wishlist?").font(.title2).fontWeight(.semibold)
                    .padding(.bottom)
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                Text("Tip: Add more tags on your profile page to get more recommendations!").font(.body)
                    .padding(.bottom)
                    .padding(.leading)
                    .padding(.trailing)
            }.background(
                Color.white
                    .cornerRadius(25.0)
                    .opacity(0.5)
                    .shadow(radius: 5, x: 5, y: 5)
                )
            ForEach(Card.data.reversed()) { card in
                CardView(card: card)
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.bottom, 60)

        .zIndex(1.0)
        
        
        
        
        
    }
}

struct CardsSection_Previews: PreviewProvider {
    static var previews: some View {
        CardsSection()
    }
}

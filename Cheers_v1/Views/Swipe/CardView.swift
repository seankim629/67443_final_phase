//
//  CardView.swift
//  Cheers_v1
//
//  Created by JP Park on 11/30/21.
//

import SwiftUI

struct CardView: View {
    @State var card: Card
    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.7)])
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(card.imageName)
                .resizable()
                .clipped()
                
            
            // Linear Gradient
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing:0){
                    HStack (spacing: 0) {
                        Text(card.name).font(.title).fontWeight(.semibold)
//                        Text(String(card.age)).font(.title)
                        Image(systemName: "star.fill").foregroundColor(Color("Highlight Color")).padding(.leading, 10).padding(.trailing, 2)
                        Text(String.init(format: "%0.1f", card.avgRating)).font(.title3)
                    }.padding(.bottom, 3)
//                    Text(card.bio).font(.body)
                    Text("ABV: " + String.init(format: "%0.1f", card.alc) + "%")
                        .font(.body)
                }
            }
            .padding()
            .foregroundColor(.white)
            
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100)
                    .opacity(Double(card.x/10 - 1))
                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
            
        }
        
        .cornerRadius(8)
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        .gesture (
            DragGesture()
                .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        // MARK: - BUG 5
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
                .onEnded { (value) in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                            // add to wishlist
                            let _ = print("hi!")
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x < -100:
                            card.x  = -500; card.degree = -12
                        default:
                            card.x = 0; card.y = 0
                        }
                    }
                }
        )
        
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.data[0])
            .previewLayout(.sizeThatFits)
    }
}

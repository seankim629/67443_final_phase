//
//  Playground.swift
//  Cheers_v1
//
//  Created by JP Park on 11/5/21.
//

import SwiftUI

extension Animation {
    static func customAnimation(index: Int) -> Animation {
        Animation.easeInOut(duration: 1)
            .delay(0.5 * Double(index))
    }
}

struct AppView: View {
    
    let data = [39.14, 50.03, 0.0, 41.43]
    
    @State var capsulesAppearing = false
    
    var body: some View {
//        GeometryReader { bounds in
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                    .opacity(0.6)
//                    .ignoresSafeArea()
//                VStack {
////                    Button {
//
////                        withAnimation {
////                            capsulesAppearing.toggle()
////                        }
////                    } label: {
////                        Text("Show/hide graph")
////                    }
//                    VStack {
//                        Text("My data points")
//                            .font(.title)
//                            .bold()
//                            .padding(.top)
//                        VStack(alignment: .leading) {
//                            ForEach(0..<data.count) { index in
//                                HStack {
//                                    LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
//                                        .frame(width:capsulesAppearing ? CGFloat(data[index] * 5 + 10) : 0,
//                                            height: 30)
//                                        .clipShape(Capsule())
//                                        .padding(.vertical, 5)
//                                        .opacity(0.8)
//                                    Spacer()
//                                    Text(String(format: "%.2f", data[index]))
//                                        .font(.caption)
//
//                                }
//                                .animation(.customAnimation(index: index))
//                            }
//                        }
//                        .padding()
//                    }
//                    .onAppear {
//                        withAnimation {
//                            capsulesAppearing.toggle()
//                        }
//                    }
//                    .background(
//                        Color.white
//                            .cornerRadius(25.0)
//                            .opacity(0.3)
//                            .shadow(radius: 5, x: 5, y: 5)
//                    )
//                    .frame(width: bounds.size.width - 50, height: bounds.size.width)
//                }
//            }
//        }
        VStack {
            Text("My data points")
                .font(.title)
                .bold()
                .padding(.top)
            VStack(alignment: .leading) {
                ForEach(0..<data.count) { index in
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .frame(width:capsulesAppearing ? CGFloat(data[index] * 5 + 10) : 0,
                                height: 30)
                            .clipShape(Capsule())
                            .padding(.vertical, 5)
                            .opacity(0.8)
                        Spacer()
                        Text(String(format: "%.2f", data[index]))
                            .font(.caption)
                        
                    }
                    .animation(.customAnimation(index: index))
                }
            }
            .padding()
        }
        .onAppear {
            withAnimation {
                capsulesAppearing.toggle()
            }
        }
        .background(
            Color.white
                .cornerRadius(25.0)
                .opacity(0.3)
                .shadow(radius: 5, x: 5, y: 5)
        )

    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

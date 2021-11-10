//
//  ProductDetailView.swift
//  Cheers_v1
//
//  Created by JP Park on 11/4/21.
//

import SwiftUI


struct DetailScreen: View {
    @Binding var barcodeValue: String?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            ScrollView  {
                //            Product Image
                    Image("Beer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                Text(barcodeValue!)

                DescriptionView()

            }

        }
    }
}






//struct DetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScreen()
//    }
//}




struct DescriptionView: View {
    @State private var rating: Double = 4.5
    var body: some View {
        VStack (alignment: .leading) {
            //                Title
            HStack() {
                Text("Carlsberg")
                    .font(.title)
                    .fontWeight(.bold)
                Image(systemName: "star.fill").padding(.leading).foregroundColor(Color("Highlight Color"))
                Text("4.9")
                    .opacity(0.5)
            }
            
            HStack() {
                StarSlider($rating)
                Text("Your Rating: " + String.init(format: "%0.1f", rating))
            }

            //                Info
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    Text("Brewery")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("Carlsberg Danmark A/S")
                        .opacity(0.6)
                }

                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack (alignment: .leading) {
                    Text("Beer Style")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("Lager - European Pale")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
            
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    Text("ABV")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("5%")
                        .opacity(0.6)
                }

                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack (alignment: .leading) {
                    Text("Bottle Size")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("12 fl oz")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)

        }
        .padding()
        .padding(.top)

    }
}




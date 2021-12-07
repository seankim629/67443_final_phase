//
//  ProductDetailView.swift
//  Cheers_v1
//
//  Created by JP Park on 11/4/21.
//

import SwiftUI

//struct Toggler: View {
//    @State private var vibrateOnRing = false
//    @ObservedObject var wishes = WishesViewModel()
//
//    var body: some View {
//        Toggle(isOn: $vibrateOnRing) {
//            Text("Vibrate on Ring")
//        }
//        .onChange(of: vibrateOnRing) { value in
//            //perform your action here...
//            print(value)
//          if value == true {
//
//          }
//        }
//    }
//}

extension Animation {
    static func customAnimation2(index: Int) -> Animation {
        Animation.easeInOut(duration: 1)
            .delay(0.3 * Double(index))
    }
}

struct DetailScreen: View {
    @Binding var barcodeValue: String?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var result = BeersViewModel()
    @ObservedObject var wish = WishesViewModel()
    @State private var isLoading = false
    
    func startNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        isLoading = false
        }
      }

    var body: some View {
        ZStack {
            
            if isLoading {
                        ZStack {
                          Color(.systemBackground)
                            .ignoresSafeArea()
                        }
                        ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: Color("Highlight Color")))
                          .scaleEffect(3)
                      }
            if isLoading == false {
                          
            ScrollView  {
                //            Product Image
                let _ = print("NUM UH WA?")
                let __ = print(result.beerImg)
                ProductImage(url: URL(string:result.beerImg))
                //Text(barcodeValue!)
//                Toggler()
                DescriptionView(prod: result.beerDetails)

            }
          }
        }
        .onAppear {
          startNetworkCall()
          result.load(barcode: barcodeValue!)
        }
        .navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Image("header").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                    Text("Cheers").fontWeight(.bold).foregroundColor(.white)}
            }
        }
    }
  
  
}




struct DescriptionView: View {
    @State private var rating: Double = 0.0
    var prod: Product
    @ObservedObject var rat = RatingsViewModel()
    @ObservedObject var wish = WishesViewModel()
    @State var isToggled = false
    
    let data = [39.14, 50.03, 0.0, 41.43]
    let palate = ["Bitter", "Sweet", "Sour", "Fruity"]
    @State var capsulesAppearing = false
    
    @State var showingPopOver = false
    @State var tags: [String] = []
    @State var keyword: String = ""

    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                HStack() {
                  Text(prod.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "star.fill").padding(.leading).foregroundColor(Color("Highlight Color"))
                    
                    Text(String.init(format: "%0.1f", prod.avgRating)).padding(.trailing)
                    Spacer()
                    Button(action: {
                          isToggled = !isToggled
                          
                          let uid = UserDefaults.standard.string(forKey: "uid")!
                          print(prod.name)
                          self.wish.checkWishlist(usrID: uid, beerName: prod.name, isAdd: isToggled)
                        }) {
                          if isToggled == true {
                            Image(systemName: "bookmark.fill").foregroundColor(Color("Highlight Color"))
                          } else {
                            Image(systemName: "bookmark").foregroundColor(Color("Highlight Color"))
                          }
                            // need a function to check if this beer is in wishlist and determine the state
                            // if it is in wishlist then set state to false and Image(systemName: "bookmark).foregroundColor(Color("Highlight Color")) and delete from wishlist
                            // if it is not in wishilst then set state to true and Image(systemName:"bookmark.filled").foregroundColor(Color("Highlight Color")) and add to wishlist
                        }.padding(.trailing)
                    
                }.padding(.top).padding(.leading)
                
                HStack() {
                  StarSlider($rating, $tags, product: prod.name, ratModel: rat).padding(.trailing)
                  if rating == 0.0 {
                    Text("Leave a Rating").font(.system(size: 16))
                      .opacity(0.7)
                  } else {
                    Text("Your Rating: " + String.init(format: "%0.1f", rating)).font(.system(size: 16))
                        .opacity(0.7)
                  }
                }.padding(.leading)

                //                Info
                HStack (alignment: .top) {
                    VStack (alignment: .leading) {
                        Text("Brewery")
                            .font(.system(size: 16))
                            .opacity(0.7)
                        Text(prod.brewery)
                            .fontWeight(.semibold)
                    }

                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack (alignment: .leading) {
                        Text("Beer Style")
                            .font(.system(size: 16))
                            .opacity(0.7)
                        Text(prod.style)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical)
                .padding(.leading)
                
                HStack (alignment: .top) {
                    VStack (alignment: .leading) {
                        Text("ABV")
                            .font(.system(size: 16))
                            .opacity(0.7)
                        Text(String.init(format: "%0.1f", prod.alc) + "%")
                            .fontWeight(.semibold)
                    }

                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack (alignment: .leading) {
                        Text("Bottle Size")
                            .font(.system(size: 16))
                            .opacity(0.7)
                        Text("12 fl oz")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical)
                .padding(.leading)
                
            }.background(
                Color.white
                    .cornerRadius(25.0)
                    .opacity(0.5)
                    .shadow(radius: 5, x: 5, y: 5)
                )
                .padding()
            
            
            VStack (alignment: .leading){
                Text("Taste Palate")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .padding(.leading)
                    .padding(.bottom)
                VStack(alignment: .leading) {
                    ForEach(0..<data.count) { index in
                        VStack{
                            Text(palate[index]).font(.caption).fontWeight(.bold)
                            HStack {
                                Text("Min").font(.caption).padding(.leading)
                                LinearGradient(gradient: Gradient(colors: [Color("Highlight Color"), Color.orange]), startPoint: .leading, endPoint: .trailing)
                                    .frame(width:capsulesAppearing ? CGFloat(data[index] * 5 + 10) : 0,
                                        height: 30)
                                    .clipShape(Capsule())
                                    .padding(.vertical, 2)
                                    .opacity(0.8)
                                Spacer()
                                Text("Max").font(.caption).padding(.trailing)
                                
                            }
                            .animation(.customAnimation2(index: index))
                        }
                        .padding(.bottom)
                    }
                }
//                .padding()
            }
            .onAppear {
                withAnimation {
                    capsulesAppearing.toggle()
                }
            }
            .background(
                Color.white
                    .cornerRadius(25.0)
                    .opacity(0.5)
                    .shadow(radius: 5, x: 5, y: 5)
            )
            .padding()
            
            
            VStack (alignment: .leading){
                    HStack (spacing:0) {
                        Text("My Hashtags")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                            .padding(.bottom)
                        Button {
                            showingPopOver = true
                        } label: {
                            Image(systemName: "square.and.pencil").padding(.leading, 5).foregroundColor(Color("Highlight Color")).font(Font.system(size: 18, weight: .bold))
                        }
                        
                    }
                    MyTagsField(tags: $tags, keyword: $keyword) { _ in
                        return tags.first
                    }
                    .padding(23)
                    .background(Color(.sRGB, red: 224.0/255.0, green: 224.0/255.0, blue: 225.0/255.0, opacity: 1))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom)
                    .padding(.leading)
                    .padding(.trailing)
                }
                .background(
                    Color.white
                        .cornerRadius(25.0)
                        .opacity(0.5)
                        .shadow(radius: 5, x: 5, y: 5)
                )
                .padding()
                .padding(.bottom)
            
            

        }
        .onAppear {
                  let uid = UserDefaults.standard.string(forKey: "uid")
                  self.wish.isInWishlist(usrID: uid ?? "", beerName: prod.name, completion: { (success) -> Void in
                    print("+==============")
                    print(success)
                    if success {
                      print("ALREADY IN!")
                      isToggled = true
                    }
                  })
                  self.rat.hasTags(usrID: uid ?? "", beerName: prod.name, completion: { (arg0) -> Void in
            
                        let (resTags, beerRating) = arg0
                        self.tags = resTags
                        self.rating = beerRating
                  })
                }
        .sheet(isPresented: $showingPopOver) {
          PreferenceView(tags: $tags, keyword: $keyword, showingPopOver: $showingPopOver, product: prod.name)}
        .padding(.bottom)

    }
}




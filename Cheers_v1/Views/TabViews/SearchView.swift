//
//  SearchView.swift
//  figmatest
//
//  Created by JP Park on 11/3/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore



struct SearchView: View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "magnifyingglass").foregroundColor(Color("Highlight Color"))
                    .font(.system(size: 28))
                Text("Search Beers")
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(Color("Background Color"))
                
                
            }.padding(.bottom, 20)
            
            
            CustomSearchBar(data: self.$data.datas)

            
            
        }.navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Image("header").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                    Text("Cheers").fontWeight(.bold).foregroundColor(.white)}
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)
            .padding(.top, 20)
            .padding(.leading, 28)
    }
}


struct CustomSearchBar : View {
    
    @State var txt = ""
    @Binding var data : [dataType]
    
    var body : some View{
        
        VStack(spacing: 0){
            
            HStack{
                
                TextField("Search", text: self.$txt)
                .padding(7)
                                .padding(.horizontal, 25)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                      .padding(.leading, 8)})
                                .padding(.horizontal, 10)

              
                if self.txt != ""{
                    
                    Button(action: {
                        
                        self.txt = ""
                        
                    }) {
                        
                        Text("Cancel")
                    }
                    .foregroundColor(.gray)
                    
                }

            }.padding(.trailing, 25)
            
            if self.txt != ""{
                
                if  self.data.filter({$0.beername.lowercased().contains(self.txt.lowercased())}).count == 0{
                    
                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                }
                else{
                    
                List(self.data.filter{$0.beername.lowercased().contains(self.txt.lowercased())})
                    {i in
                      NavigationLink(destination: SearchDetailScreen(beerName: i.beername)) {
                        Text(i.beername)
                      }
                            
                        
                    }.frame(height: UIScreen.main.bounds.height / 3).padding(.trailing, 25).padding(.top, 25)
                }

            }
            
            
        }
        .background(Color.white)
        .padding()
    }
}




class getData : ObservableObject{
    
    @Published var datas = [dataType]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("beers").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("Name") as! String
                
                self.datas.append(dataType(id: id, beername: name))
            }
        }
    }
}

struct dataType : Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var beername : String
}

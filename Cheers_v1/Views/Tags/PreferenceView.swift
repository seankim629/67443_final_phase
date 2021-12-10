//
//  PreferenceView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 11/29/21.
//

import SwiftUI



struct PreferenceView: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    @Binding var showingPopOver: Bool
    var product: String
    var photo: String
    @ObservedObject var rat = RatingsViewModel()
    @State var newTags: [String] = []
    @State var removedTags: [String] = []
    
    var body: some View {
        VStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 100)
            .fill(Color.white)
            .frame(width: 134, height: 5)
            .padding(.top, 15)
            Spacer()
            searchView
            Divider()
            searchResultView
            Spacer()
            
        }.background(Color("Background Color"))
    }
    
    
    @ViewBuilder
    var searchResultView: some View {
        VStack(alignment: .leading, spacing: 10) {
          TagTextField(tags: $tags, keyword: $keyword, newTags: $newTags, removedTags: $removedTags) { _ in
                return tags.first
            }
            .padding(23)
            .background(Color(.sRGB, red: 224.0/255.0, green: 224.0/255.0, blue: 225.0/255.0, opacity: 1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack {
                Spacer()
                Button(action: {
                    for elem in removedTags {
                        tags.removeAll(where: {$0 == elem})
                    }
                    self.tags = self.tags + self.newTags
                    let uid = UserDefaults.standard.string(forKey: "uid")
                    let rid = UserDefaults.standard.string(forKey: "ratingid")
                    let date = Date()
                    var newRating: [String: Any] = [
                      "datetime": date,
                      "rating": 0.0,
                      "userid": 1,
                      "productname": product,
                      "tags": self.tags,
                      "photo": photo
                    ]
                    print(rid)
                    if rid != nil {
                      print("UPDATE NEW TAGS")
//                      newRating = [
//                        "productname": product,
//                        "tags" : self.tags]
                      rat.checkRating(usrID: uid ?? "", newData: newRating)
                    } else {
                      print("ADD NEW TAGS")
                      rat.checkRating(usrID: uid ?? "", newData: newRating)
                    }
                    self.showingPopOver = false
                }, label:  {
                    Text("Save")
                    .fontWeight(.semibold)
                    .padding(10)
                    .padding(.trailing, 5)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)
                    .background(Color("Highlight Color"))
                    .cornerRadius(16)
                }).frame(minWidth: 150)
                Spacer()
            }
            .padding(.top, 15)
            
            
        }
        .padding(16)
        
//        Button("Save") {
//            self.showingPopOver = false
//        }
    }
    
    @ViewBuilder
    var searchView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Add Hashtags")
                .font(.title2)
                .bold()
                .padding(.top)
                .padding(.bottom)
            HStack() {
                SearchTextField(tags: $tags, keyword: $keyword, newTags: $newTags, placeholder: " Tags") { _ in
                return keyword
            }
            .padding(8)
            .background(Color(.white))
            .cornerRadius(8)
//            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            }
        
        }
        .padding(16)
        
//        if (allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}).count > 0 {
//            List {
//                ForEach((allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}), id: \.self) { tag in
//                    Button(action: {
//                        if tags.contains(tag) == false {
//                            tags.append(tag)
//                        }
//                        keyword = ""
//                    }, label: {
//                        Text(tag)
//                            .padding()
//                    })
//                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
//                }
//            }
//        }
//        else {
//            VStack(alignment: .center, spacing: 0) {
//                Spacer()
//
//                Text("No tags found")
//                    .font(Font.system(size: 16))
//                    .foregroundColor(Color.secondary)
//                    .padding(.top, 20)
//
//                Spacer()
//            }
//        }
//        SearchTextField(tags: $tags, keyword: $keyword, theme: self.theme) { _ in
//            return allTags.first
//        }
//        .padding(6)
//        .background(Color(.sRGB, red: 224.0/255.0, green: 224.0/255.0, blue: 225.0/255.0, opacity: 1))
    }
}


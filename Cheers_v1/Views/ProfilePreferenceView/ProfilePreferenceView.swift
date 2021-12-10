//
//  SearchFilterField.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 12/8/21.
//

import SwiftUI



struct ProfilePreferenceView: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    @Binding var showingPopOver: Bool
    @State var newTags: [String] = []
    @State var removedTags: [String] = []
    @ObservedObject var usr = UsersViewModel()
    var allTags : [String] = ["Lager - American Amber / Red", "Lager - American", "Lager - Light", "Lager - Märzen / Oktoberfest", "Pale Ale - English", "Pilsner - German", "Porter - American", "Barleywine - English", "Bitter - English", "Blonde Ale - American", "Dubbel", "Farmhouse Ale - Saison", "IPA - English", "Kölsch", "Pale Ale - American", "Sour - Flanders Oud Bruin", "Strong Ale - Belgian Pale", "Wheat Beer - American Pale", "Wheat Beer - Wheatwine", "Wild Ale", "Barleywine - American", "Fruit and Field Beer", "IPA - American", "IPA - Black / Cascadian Dark Ale", "Red Ale - American Amber / Red", "Stout - English", "Strong Ale - Belgian Dark", "Tripel", "Winter Warmer", "Lager - Japanese Rice", "Lager - Munich Dunkel", "Lager - Adjunct", "Lager - Malt Liquor", "Low Alcohol Beer", "Chile Beer", "Lager - Vienna", "Pilsner - Bohemian / Czech", "Brown Ale - American", "Lager - Schwarzbier", "Pumpkin Beer", "Stout - Irish Dry", "Stout - Russian Imperial", "Brown Ale - English", "Lager - European Pale", "Bock - Doppelbock", "Lager - European / Dortmunder Export", "Lager - European Dark", "Herb and Spice Beer", "Mild Ale - English Dark", "Porter - English", "Strong Ale - English", "IPA - Imperial", "Red Ale - Imperial", "Stout - Oatmeal", "Stout - Sweet / Milk", "Wheat Beer - Hefeweizen", "Old Ale", "Scotch Ale / Wee Heavy", "Stout - American Imperial", "Wheat Beer - Witbier", "Bock - Traditional", "Wheat Beer - American Dark", "Strong Ale - American", "Red Ale - Irish", "Blonde Ale - Belgian", "Bock - Weizenbock", "Brett Beer", "Lager - Helles", "Lager - India Pale Lager (IPL)", "Quadrupel (Quad)", "Sour - Gose", "Sour - Berliner Weisse", "Stout - Foreign / Export", "IPA - New England", "Lager - Kellerbier / Zwickelbier", "Wheat Beer - Kristallweizen", "Cream Ale", "Farmhouse Ale - Sahti", "Pilsner - Imperial", "Stout - American", "Bitter - English Extra Special / Strong Bitter (ESB)", "Bock - Maibock", "IPA - Belgian", "Lager - Rauchbier", "IPA - Brut", "Porter - Robust", "Rye Beer", "Porter - Baltic", "Scottish Ale", "Bière de Champagne / Bière Brut", "Brown Ale - Belgian Dark", "Lambic - Fruit", "Lambic - Gueuze", "Pale Ale - Belgian", "California Common / Steam Beer", "Porter - Imperial", "Lambic - Traditional", "Lager - European Strong", "Smoked Beer", "Happoshu", "Altbier", "Bock - Eisbock", "Farmhouse Ale - Bière de Garde", "Porter - Smoked"]
    
    var body: some View {
        VStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 100)
            .fill(Color.white)
            .frame(width: 134, height: 5)
            .padding(.top, 15)
            Spacer()
            searchView
            Divider()
            searchFilterView
            Divider()
            searchResultView
            Spacer()
            
        }.background(Color("Background Color"))
    }
    
    
    @ViewBuilder
    var searchResultView: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProfileTagTextField(tags: $tags, keyword: $keyword, newTags: $newTags, removedTags: $removedTags) { _ in
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
                    self.usr.addPref(newPref: self.tags)
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
              ProfileSearchTextField(tags: $tags, keyword: $keyword, newTags: $newTags,  allTags: allTags, placeholder: " Tags") { _ in
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
    
    @ViewBuilder
    var searchFilterView: some View {
        if (allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}).count > 0 {
            List {
                ForEach((allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}), id: \.self) { tag in
                    Button(action: {
                        if newTags.contains(tag) == false {
                            newTags.append(tag)
                        }
                        keyword = ""
                    }, label: {
                        Text(tag)
                            .padding()
                    })
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                }
            }
        }
        else {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Text("No tags found")
                    .font(Font.system(size: 16))
                    .foregroundColor(Color.secondary)
                    .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

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
    var allTags: [String] = ["Altbier", "Barleywine - American", "Barleywine - English", "Bitter - English Extra Special / Strong Bitter (ESB)", "Bitter - English", "Bière de Champagne / Bière Brut", "Blonde Ale - American", "Blonde Ale - Belgian", "Bock - Doppelbock", "Bock - Eisbock", "Bock - Maibock", "Bock - Traditional", "Bock - Weizenbock", "Braggot", "Brett Beer", "Brown Ale - American", "Brown Ale - Belgian Dark", "Brown Ale - English", "California Common / Steam Beer", "Chile Beer", "Cream Ale", "Dubbel", "Farmhouse Ale - Bière de Garde", "Farmhouse Ale - Sahti", "Farmhouse Ale - Saison", "Fruit and Field Beer", "Gruit / Ancient Herbed Ale", "Happoshu", "Herb and Spice Beer", "IPA - American", "IPA - Belgian", "IPA - Black / Cascadian Dark Ale", "IPA - Brut", "IPA - English", "IPA - Imperial", "IPA - New England", "Kvass", "Lager - Adjunct", "Kölsch", "Lager - American Amber / Red", "Lager - American", "Lager - European / Dortmunder Export", "Lager - European Dark", "Lager - European Pale", "Lager - European Strong", "Lager - Helles", "Lager - India Pale Lager (IPL)", "Lager - Japanese Rice", "Lager - Kellerbier / Zwickelbier", "Lager - Light", "Lager - Malt Liquor", "Lager - Munich Dunkel", "Lager - Märzen / Oktoberfest", "Lager - Rauchbier", "Lager - Schwarzbier", "Lager - Vienna", "Lambic - Faro", "Lambic - Fruit", "Lambic - Gueuze", "Lambic - Traditional", "Low Alcohol Beer", "Mild Ale - English Dark", "Mild Ale - English Pale", "Old Ale", "Pale Ale - American", "Pale Ale - Belgian", "Pale Ale - English", "Pilsner - Bohemian / Czech", "Pilsner German", "Pilsner - Imperial", "Porter - American", "Porter - Baltic", "Porter - English", "Porter - Imperial", "Porter - Robust", "Porter - Smoked", "Pumpkin Beer", "Quadrupel (Quad)", "Red Ale - American Amber / Red", "Red Ale - Imperial", "Red Ale - Irish", "Rye Beer - Roggenbier", "Rye Beer", "Scotch Ale / Wee Heavy", "Scottish Ale", "Smoked Beer", "Sour - Berliner Weisse", "Sour - Flanders Oud Bruin", "Sour - Flanders Red Ale", "Sour - Gose", "Stout - American Imperial", "Stout - American", "Stout - English", "Stout - Foreign / Export", "Stout - Irish Dry", "Stout - Oatmeal", "Stout - Russian Imperial", "Stout - Sweet / Milk", "Strong Ale - American", "Strong Ale - Belgian Dark", "Strong Ale - Belgian Pale", "Strong Ale - English", "Tripel", "Wheat Beer - American Dark", "Wheat Beer - American Pale", "Wheat Beer - Dunkelweizen", "Wheat Beer - Hefeweizen", "Wheat Beer - Kristallweizen", "Wheat Beer - Wheatwine", "Wheat Beer - Witbier", "Wild Ale", "Winter Warmer"]
    
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

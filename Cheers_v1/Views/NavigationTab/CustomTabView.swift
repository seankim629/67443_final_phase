//
//  CustomTabView.swift
//  figmatest
//
//  Created by JP Park on 11/4/21.
//

import SwiftUI


struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Group{
                Spacer()
                Button {
                    selectedTab = .home
                } label: {
                    VStack{
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Home")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .home ? Color("Highlight Color") : .white)
                    
                }
                Spacer()
                Button {
                    selectedTab = .search
                } label: {
                    VStack(alignment: .center) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Search")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .search ? Color("Highlight Color") : .white)
                    
                }
                Spacer()
            }
            
            
            Button {
                selectedTab = .scan
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color("Highlight Color"))
                        .frame(width: 75, height: 75)
                        .shadow(radius: 2)
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .foregroundColor(Color("Background Color"))
                        .frame(width: 62, height: 62)
                }
                .offset(x:-3, y: -32)
            }
            .buttonStyle(TabButtonStyle())
            
            Group {
                Spacer()
                Button {
                    selectedTab = .feed
                } label: {
                    VStack{
                        Image(systemName: "text.bubble.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Feed")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .feed ? Color("Highlight Color") : .white)
                    
                }
                Spacer()
                Button {
                    selectedTab = .profile
                } label: {
                    VStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Profile")
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == .profile ? Color("Highlight Color") : .white)
                    
                }
                Spacer()
            }
            
        }.background(Color("Background Color"))
    }
}


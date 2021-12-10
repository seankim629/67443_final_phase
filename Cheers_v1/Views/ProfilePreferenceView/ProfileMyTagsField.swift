//
//  ProfileMyTagsField.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 12/2/21.
//

import SwiftUI
import UIKit



public struct ProfileMyTagsField: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    
    var theme: MyTagsTheme = MyTagsTheme()
    var placeholder: String = ""
    var checkKeyword: ((String) -> String?)? = { $0 } //this is a closure is to get a candidate for the currently inputed text
        
    @State private var availableWidth: CGFloat = 0
    @State private var elementsSize: [String: CGSize] = [:]
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: theme.alignment, vertical: .center)) {
            Color.clear
                .frame(height: 2)
                .readSize { size in
                    availableWidth = size.width
                }
            
            myTagsContainer
        }
    }
    
    var myTagsContainer: some View {
        let rows = computeRows()
        return VStack(alignment: theme.alignment, spacing: theme.spacing) {
            ForEach(0..<rows.count, id: \.self) { index in
                HStack(spacing: theme.spacing) {
                    ForEach(rows[index], id: \.self) { element in
                        ProfileMyTagView(tag: element, theme: theme)
                        .fixedSize()
                        .readSize { size in
                            elementsSize[element] = size
                        }
                    }
//                    if index == rows.count - 1 {
//                        textInputView
//                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func computeRows() -> [[String]] {
        var rows: [[String]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in tags {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 10)]
            
            if remainingWidth - (elementSize.width + theme.spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            remainingWidth = remainingWidth - (elementSize.width + theme.spacing)
        }
        return rows
    }
}

public struct ProfileMyTagView: View {
    let tag: String
    let theme: MyTagsTheme
//    var deleteAction: (()->Void) = {}
        
    public var body: some View {
        HStack (spacing: 5) {
            
            Text("#" + String.init(tag))
                .font(theme.font)
                .foregroundColor(theme.foregroundColor)
//            if theme.deletable {
//                Button(action: deleteAction, label: {
//                    Image(systemName: theme.deleteButtonSystemImageName)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(theme.deleteButtonColor)
//                        .frame(width: theme.deleteButtonSize, height: theme.deleteButtonSize)
//                })
//            }
        }
        .padding(theme.contentInsets)
        .background(theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadius).stroke(theme.borderColor, lineWidth: 1.0)
                .shadow(color: theme.shadowColor, radius: theme.shadowRadius)
        )
    }
}

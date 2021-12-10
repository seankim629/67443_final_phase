//
//  TagTextField.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 12/1/21.
//

import SwiftUI
import UIKit




public struct ProfileTagTextField: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    @Binding var newTags: [String]
    @Binding var removedTags: [String]
    

    var theme: TagTheme = TagTheme()
    var placeholder: String = ""
    var checkKeyword: ((String) -> String?)? = { $0 } //this is a closure is to get a candidate for the currently inputed text
    @State private var displayedTags: [String] = []
    @State private var availableWidth: CGFloat = 0
    @State private var elementsSize: [String: CGSize] = [:]
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: theme.alignment, vertical: .center)) {
            Color.clear
                .frame(height: 2)
                .readSize { size in
                    availableWidth = size.width
                }
            
            tagContainer
        }
    }
    
    var tagContainer: some View {
        let rows = computeRows()
        return VStack(alignment: theme.alignment, spacing: theme.spacing) {
            ForEach(0..<rows.count, id: \.self) { index in
                HStack(spacing: theme.spacing) {
                    ForEach(rows[index], id: \.self) { element in
                        ProfileTagView(tag: element, theme: theme, deleteAction: {
                            newTags.removeAll(where: {$0 == element})
                            removedTags.append(element)
                        })
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
        var combined = tags + newTags
        for element in removedTags {
            combined.removeAll(where: {$0 == element})
        }
        for element in combined {
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

public struct ProfileTagView: View {
    let tag: String
    let theme: TagTheme
    var deleteAction: (()->Void) = {}
        
    public var body: some View {
        HStack (spacing: 5) {
            
            Text("#" + String.init(tag))
                .font(theme.font)
                .foregroundColor(theme.foregroundColor)
            if theme.deletable {
                Button(action: deleteAction, label: {
                    Image(systemName: theme.deleteButtonSystemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(theme.deleteButtonColor)
                        .frame(width: theme.deleteButtonSize, height: theme.deleteButtonSize)
                })
            }
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

//public struct TagTextField_Previews: PreviewProvider {
//    public static var previews: some View {
//        Group {
//            TagTextField(tags: .constant(["hu"]), keyword: .constant(""), placeholder: "Tags")
//                .padding(20)
//                .background(Color(.sRGB, red: 244.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, opacity: 1))
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//        }.padding()
//    }
//}

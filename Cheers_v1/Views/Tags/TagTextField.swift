//
//  TagTextField.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 12/1/21.
//

import SwiftUI
import UIKit

public struct TagTheme {
    var font: Font = Font.system(size: 14)
    var foregroundColor: Color = Color(.sRGB, red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, opacity: 1)
    var backgroundColor: Color = Color.white
    var borderColor: Color = Color(.sRGB, red: 224.0/255.0, green: 224.0/255.0, blue: 225.0/255.0, opacity: 1)
    var shadowColor: Color = Color(.sRGB, red: 151.0/255.0, green: 151.0/255.0, blue: 154.0/255.0, opacity: 1).opacity(0.4)
    var shadowRadius: CGFloat = 5
    var cornerRadius: CGFloat = 13
    
    var deletable: Bool = true
    var deleteButtonSize: CGFloat = 12
    var deleteButtonColor: Color = Color(.sRGB, red: 151.0/255.0, green: 151.0/255.0, blue: 154.0/255.0, opacity: 1)
    var deleteButtonSystemImageName: String = "xmark"
    
    var spacing: CGFloat = 5.0
    var alignment: HorizontalAlignment = .leading
    
    var inputFieldFont: Font = Font.system(size: 14)
    var inputFieldTextColor: Color = Color(.sRGB, red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, opacity: 1)
    
    var contentInsets: EdgeInsets = EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
}


public struct TagTextField: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    @Binding var newTags: [String]
    

    var theme: TagTheme = TagTheme()
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
            
            tagContainer
        }
    }
    
    var tagContainer: some View {
        let rows = computeRows()
        return VStack(alignment: theme.alignment, spacing: theme.spacing) {
            ForEach(0..<rows.count, id: \.self) { index in
                HStack(spacing: theme.spacing) {
                    ForEach(rows[index], id: \.self) { element in
                        TagView(tag: element, theme: theme, deleteAction: {
                            tags.removeAll(where: {$0 == element})
                            newTags.removeAll(where: {$0 == element})
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
        let combined = tags + newTags
        
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

public struct TagView: View {
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

internal struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

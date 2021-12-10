//
//  SearchTextField.swift
//  TagTextField
//
//  Created by Sung Tae Kim on 12/1/21.
//

import SwiftUI
import UIKit

struct ProfileSuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}



public struct ProfileSearchTextField: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    @Binding var newTags: [String]
  
    var allTags: [String] = []
    var theme: TagTheme = TagTheme()
    var placeholder: String = "Add Hashtags"
    var checkKeyword: ((String) -> String?)? = { $0 } //this is a closure is to get a candidate for the currently inputed text
        
    @State private var availableWidth: CGFloat = 0
    @State private var elementsSize: [String: CGSize] = [:]
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: theme.alignment, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            searchContainer
        }
    }
    
    
    var searchContainer: some View {
//        let rows = computeRows()
//        return VStack(alignment: theme.alignment, spacing: theme.spacing) {
//            ForEach(0..<rows.count, id: \.self) { index in
//
//                    if index == rows.count - 1 {
                        textInputView
//                    }
//
//            }
//        }
    }
    
    
    @ViewBuilder
    var textInputView: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            
            ProfileSuperTextField(
                        placeholder: Text("Search tags").foregroundColor(.gray),
                        text: $keyword, commit: {
                            if keyword.count > 0,
                               let result = checkKeyword?(keyword), tags.contains(result) == false && newTags.contains(result) == false && allTags.contains(result){
                                
                                newTags.append(result)
                            }
                            keyword = ""
                        }
                    )
            
        }
        
        .textFieldStyle(PlainTextFieldStyle())
        .font(theme.inputFieldFont)
        .foregroundColor(theme.inputFieldTextColor)
        .disableAutocorrection(true)
        .autocapitalization(.none)
    }
    
//    func computeRows() -> [[String]] {
//        var rows: [[String]] = [[]]
//        var currentRow = 0
//        var remainingWidth = availableWidth
//
//        let combined = tags + newTags
//        for element in combined {
//            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
//
//            if remainingWidth - (elementSize.width + theme.spacing) >= 0 {
//                rows[currentRow].append(element)
//            } else {
//                currentRow = currentRow + 1
//                rows.append([element])
//                remainingWidth = availableWidth
//            }
//            remainingWidth = remainingWidth - (elementSize.width + theme.spacing)
//        }
//        return rows
//    }
}


//public struct SearchTextField_Previews: PreviewProvider {
//    public static var previews: some View {
//        Group {
//            SearchTextField(tags: .constant(["SwiftUI", "Apple", "Java", "Javascript", "Objective-C", "Kotlin"]), keyword: .constant(""), placeholder: "Tags")
//                .padding(6)
//                .background(Color(.sRGB, red: 244.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, opacity: 1))
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//        }.padding()
//    }
//}

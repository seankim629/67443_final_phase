//
//  Card.swift
//  Cheers_v1
//
//  Created by JP Park on 11/30/21.
//

import SwiftUI

//MARK: - DATA
struct Card: Identifiable {
    let id = UUID()
    let name: String
    let fakeName: String
    let imageName: String
    let avgRating: Double
    let alc: Double
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
//    static var data: [Card] {
//        [
//            Card(name: "Carlsberg", imageName: "p0", avgRating: 4.5, alc: 4.2),
//            Card(name: "Corona Extra", imageName: "p1", avgRating: 4.1, alc: 3.8),
//            Card(name: "Heineken", imageName: "p2", avgRating: 4.2, alc: 8.2),
//            Card(name: "Yuengling", imageName: "p3", avgRating: 4.3, alc: 7.3),
//            Card(name: "Blue Moon", imageName: "p4", avgRating: 4.4, alc: 5.4),
//            Card(name: "Budweiser", imageName: "p5", avgRating: 4.6, alc: 5.2),
//        ]
//    }
    
}

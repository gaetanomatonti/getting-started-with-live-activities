//
//  Line.swift
//  ExpressGroceries
//
//  Created by Gaetano Matonti on 10/08/22.
//

import SwiftUI

/// A line shape aligned vertically to the center of the view containing it.
struct Line: Shape {
  func path(in rect: CGRect) -> Path {
    let rectStart = CGPoint(x: rect.minX, y: rect.midY)
    let rectEnd = CGPoint(x: rect.maxX, y: rect.midY)
    
    var path = Path()
    
    path.move(to: rectStart)
    path.addLine(to: rectEnd)
    
    return path
  }
}

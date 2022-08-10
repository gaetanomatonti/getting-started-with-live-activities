//
//  Font+Extensions.swift
//  ExpressGroceries
//
//  Created by Gaetano Matonti on 10/08/22.
//

import SwiftUI

extension Font {
  static func expandedBold(style: UIFont.TextStyle) -> Font {
    let fontDescriptor = UIFont.preferredFont(forTextStyle: style)
      .fontDescriptor
      .addingAttributes(
        [
          kCTFontVariationAttribute as UIFontDescriptor.AttributeName: [
            0x77647468: 132,
            0x77676874: 760
          ]
        ]
      )
    
    return Font(CTFont(fontDescriptor, size: fontDescriptor.pointSize))
  }
}

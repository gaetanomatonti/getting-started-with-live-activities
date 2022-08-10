//
//  DeliveryStep.swift
//  ExpressGroceries
//
//  Created by Gaetano Matonti on 10/08/22.
//

import Foundation

/// The steps of an order delivery.
enum DeliveryStep: String, Codable, CaseIterable {
  /// The order has been received and is being prepared.
  case preparing
  
  /// The order is in delivery.
  case delivering
  
  /// The order has been delivered to the customer.
  case delivered
  
  var index: Int {
    switch self {
      case .preparing:
        return 0
        
      case .delivering:
        return 1
        
      case .delivered:
        return 2
    }
  }
}

extension DeliveryStep: Identifiable {
  var id: Int {
    index
  }
}

extension DeliveryStep {
  /// The footnote of the delivery step.
  var footnote: String {
    switch self {
      case .preparing:
        return "Preparing your goodies!"
        
      case .delivering:
        return "We should be there by "
        
      case .delivered:
        return "Remember to refrigerate fresh goods."
    }
  }
  
  /// The SF symbol displayed in the Live Activity footer.
  var symbol: String {
    switch self {
      case .preparing:
        return "shippingbox"
        
      case .delivering:
        return "clock"
        
      case .delivered:
        return "refrigerator"
    }
  }
}

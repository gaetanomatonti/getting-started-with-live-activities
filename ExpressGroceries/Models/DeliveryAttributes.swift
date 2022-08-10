//
//  DeliveryAttributes.swift
//  ExpressGroceries
//
//  Created by Gaetano Matonti on 10/08/22.
//

import ActivityKit
import Foundation

/// The attributes of a Delivery Live Activity.
struct DeliveryAttributes: ActivityAttributes {
  /// The number of items in the order.
  let numberOfItems: Int
}

extension DeliveryAttributes {
  typealias ContentState = State
  
  /// The state of the Delivery activity.
  struct State: Codable, Hashable {
    /// The current step of the delivery.
    let currentStep: DeliveryStep
    
    /// The ETA of the groceries delivery.
    let estimatedTimeOfArrival: Date
  }
}

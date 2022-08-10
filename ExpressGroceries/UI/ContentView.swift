//
//  ContentView.swift
//  ExpressGroceries
//
//  Created by Gaetano Matonti on 10/08/22.
//

import ActivityKit
import SwiftUI

struct ContentView: View {
  /// The number of items in the order.
  private let numberOfItems = 14
  
  /// The ETA of the groceries delivery.
  private let estimatedTimeOfArrival = Date.now.addingTimeInterval(3 * 60 * 60)
  
  @State var activity: Activity<DeliveryAttributes>?
  
  var body: some View {
    VStack {
      Button("Start Live Activity") {
        startGroceryDeliveryTracking()
      }
      
      Button("Update Live Activity") {
        Task {
          await updateGroceryDeliveryTracking()
        }
      }

      Button("End Live Activity") {
        Task {
          await endGroceryDeliveryTracking()
        }
      }
    }
    .buttonStyle(.borderedProminent)
  }
  
  /// Starts a new grocery delivery Live Activity.
  func startGroceryDeliveryTracking() {
    let initialAttributes = DeliveryAttributes(numberOfItems: numberOfItems)
    
    let initialState = DeliveryAttributes.State(
      currentStep: .preparing,
      estimatedTimeOfArrival: estimatedTimeOfArrival
    )
    
    do {
      activity = try Activity<DeliveryAttributes>.request(
        attributes: initialAttributes,
        contentState: initialState,
        pushType: nil
      )
    } catch {
      print("Failed to request a new live activity: \(error.localizedDescription)")
    }
  }
  
  /// Updates the currently running Live Activity.
  func updateGroceryDeliveryTracking() async {
    guard let activity else {
      return
    }
    
    let updatedState = DeliveryAttributes.State(
      currentStep: .delivering,
      estimatedTimeOfArrival: activity.contentState.estimatedTimeOfArrival
    )
    
    await activity.update(using: updatedState)
  }
  
  /// Ends the currently running live activity.
  func endGroceryDeliveryTracking() async {
    guard let activity else {
      return
    }
    
    let updatedState = DeliveryAttributes.State(
      currentStep: .delivered,
      estimatedTimeOfArrival: activity.contentState.estimatedTimeOfArrival
    )
    
    await activity.end(using: updatedState, dismissalPolicy: .default)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

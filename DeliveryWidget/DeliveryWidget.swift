//
//  DeliveryWidget.swift
//  DeliveryWidget
//
//  Created by Gaetano Matonti on 10/08/22.
//

import ActivityKit
import SwiftUI
import WidgetKit

fileprivate struct DeliveryWidgetView: View {
  /// The number of items in the order.
  let numberOfItems: Int

  /// The current step of the delivery.
  let currentStep: DeliveryStep
  
  /// The ETA of the groceries delivery.
  let estimatedTimeOfArrival: Date

  // MARK: - Body
  
  var body: some View {
    VStack(spacing: .zero) {
      VStack(spacing: 24) {
        title
        
        progressBar
          .padding(.horizontal, 8)
      }
      .scenePadding()
      
      footer
    }
    .background(.background)
    .activitySystemActionForegroundColor(.darkGreen)
  }
  
  // MARK: - Subviews
  
  private var title: some View {
    HStack {
      Image(systemName: "carrot")
        .symbolVariant(.fill)
        .foregroundColor(.orange)
        .font(.subheadline)
      
      Text("Express Groceries")
        .font(.expandedBold(style: .body))
      
      Spacer()
      
      Label("\(numberOfItems)", systemImage: "cart")
        .symbolVariant(.fill)
        .font(.caption)
        .bold()
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemFill), in: Capsule())
    }
  }
  
  private var progressBar: some View {
    HStack(spacing: 2) {
      ForEach(DeliveryStep.allCases) { step in
        stepView(isCurrent: step == currentStep, isCompleted: step.index < currentStep.index)
        
        if step != .delivered {
          Spacer()
          
          if step.index < currentStep.index {
            line
          } else {
            dashedLine
          }
          
          Spacer()
        }
      }
    }
  }
  
  private var dashedLine: some View {
    HStack(spacing: 12) {
      ForEach(0..<5) { _ in
        Line()
          .stroke(.tertiary, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
          .frame(height: 3)
      }
    }
  }
  
  private var line: some View {
    Line()
      .stroke(.primary, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
      .frame(height: 3)
      .foregroundColor(.darkGreen)
  }
  
  private var footer: some View {
    HStack {
      Group {
        if currentStep == .delivering {
          Text(currentStep.footnote) +
          
          Text(estimatedTimeOfArrival, style: .time)
            .bold()
        } else {
          Text(currentStep.footnote)
        }
      }
      .font(.footnote)

      Spacer()
      
      Image(systemName: currentStep.symbol)
        .symbolVariant(.fill)
    }
    .foregroundColor(.white)
    .scenePadding()
    .background(Color.darkGreen)
  }

  @ViewBuilder
  private func stepView(isCurrent: Bool, isCompleted: Bool) -> some View {
    if isCurrent {
      ZStack {
        Color.clear
          .frame(width: 10, height: 10)
          .layoutPriority(1)
        
        Image(systemName: "box.truck")
          .symbolVariant(.fill)
          .foregroundColor(.darkGreen)
          .font(.title3)
      }
    } else {
      Circle()
        .stroke(.secondary, lineWidth: 3)
        .foregroundColor(isCompleted ? .darkGreen : .secondary)
        .frame(width: 10, height: 10)
    }
  }
}

@main
struct DeliveryWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(attributesType: DeliveryAttributes.self) { context in
      DeliveryWidgetView(
        numberOfItems: context.attributes.numberOfItems,
        currentStep: context.state.currentStep,
        estimatedTimeOfArrival: context.state.estimatedTimeOfArrival
      )
    }
  }
}

// MARK: - Previews

struct DeliveryWidgetView_Preview: PreviewProvider {
  static var previews: some View {
    Group {
      DeliveryWidgetView(numberOfItems: 14, currentStep: .preparing, estimatedTimeOfArrival: .now)
      DeliveryWidgetView(numberOfItems: 14, currentStep: .delivering, estimatedTimeOfArrival: .now)
      DeliveryWidgetView(numberOfItems: 14, currentStep: .delivered, estimatedTimeOfArrival: .now)
    }
    .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

//
//  ScrollViewPaginView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 03/11/2024.
//

import SwiftUI

struct ScrollViewPaginView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0..<20) { index in
                    Rectangle()
//                        .frame(width: 300, height: 700)
                        .overlay(
                            Text("\(index)")
                                .foregroundColor(.white)
                        )
                        .containerRelativeFrame(.vertical, alignment: .center)
                }
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPaginView()
}

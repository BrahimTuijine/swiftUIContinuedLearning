//
//  ScrollViewPaginView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 03/11/2024.
//

import SwiftUI

struct ScrollViewPaginView: View {
    
    @State var scrollPositon : Int? = nil
    
    var body: some View {
        VStack {
            Button("Scroll To") {
                withAnimation {
                    scrollPositon = 10
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<20) { index in
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .padding(10)
                            .overlay(
                                Text("\(index)")
                                    .foregroundColor(.white)
                            )
                            .id(index)
                            .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                    .opacity(phase.isIdentity ? 1 : 0)
                            }
//                            .containerRelativeFrame(.horizontal, alignment: .center)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPositon, anchor: .center)
        }
//        ScrollView(showsIndicators: false) {
//            VStack(spacing: 0) {
//                ForEach(0..<20) { index in
//                    Rectangle()
////                        .frame(width: 300, height: 700)
//                        .overlay(
//                            Text("\(index)")
//                                .foregroundColor(.white)
//                        )
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
//        .scrollTargetBehavior(.paging)
//        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPaginView()
}

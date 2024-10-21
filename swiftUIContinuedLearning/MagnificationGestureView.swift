//
//  MagnificationGestureView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 20/10/2024.
//

import SwiftUI

struct MagnificationGestureView: View {
    
    @State var currentAmount: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Circle().frame(width: 35,height: 35)
                Text("brahim tuijine")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle().frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged {
                            currentAmount = $0 - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding()
            .font(.headline)
            Text("This is the caption of my photo")
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(.horizontal)
        }
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        print(value)
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        withAnimation(.easeInOut) {
//                            currentAmount = 0
//                        }
//                    }
//            )
    }
}

#Preview {
    MagnificationGestureView()
}

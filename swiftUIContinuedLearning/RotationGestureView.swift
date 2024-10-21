//
//  RotationGestureView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 21/10/2024.
//

import SwiftUI

struct RotationGestureView: View {
    
    @State var angle : Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(40)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
            
        
    }
}

#Preview {
    RotationGestureView()
}

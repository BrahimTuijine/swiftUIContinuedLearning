//
//  DragGesture2.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 21/10/2024.
//

import SwiftUI

struct DragGesture2: View {
    
    @State var startOffset : CGFloat = UIScreen.main.bounds.height * 0.83
    
    @State var currentDragOffsetY : CGFloat = 0
    
    @State var endDragOffsetY : CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            MySignUpView()
                .offset(y: startOffset)
                .offset(y: currentDragOffsetY)
                .offset(y: endDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            currentDragOffsetY = value.translation.height
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endDragOffsetY = -startOffset
                                } else if endDragOffsetY != 0  &&  currentDragOffsetY > 150 {
                                    endDragOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0
                                
                            }
                        }
                )
            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
}

#Preview {
    DragGesture2()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "chevron.up")
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the decription for our app. This is my favorite SwiftuI course and I recommend to all of my friends to subscribe to Swiftful Thinking!")
                .multilineTextAlignment(.center)
            
            Text("Create an account")
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.cornerRadius(30))
    }
}

//
//  LongPressGestureView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 20/10/2024.
//

import SwiftUI

struct LongPressGestureView: View {
    
    @State var isComplete : Bool = false
    @State var isSuccess : Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(height: 55)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: isComplete ? .center : .leading)
                .background(.gray)
                
            HStack {
                Text("click here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture (minimumDuration: 1) {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressed in
                        if isPressed {
                            withAnimation(.easeInOut(duration: 1)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                if !isSuccess {
                                    withAnimation(.easeOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }

                
                Text("reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isSuccess = false
                            isComplete = false
                        }
                    }
            }
        }
        
//        Text(isComplete ? "COMPLETED" : "NOT COMPLETED")
//            .foregroundColor(isComplete ? .white : .black)
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? .green : .gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 2, maximumDistance: 50) {
//                isComplete.toggle()
//            }
    }
}

#Preview {
    LongPressGestureView()
}

//
//  SubscriberView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 29/10/2024.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    
    var timer : AnyCancellable?
    
    init() {
        setUpTimer()
    }
    
    
    func setUpTimer() -> Void {
       timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                
                self.count += 1
                
                if count >= 10 {
                    self.timer?.cancel()
                }
                
            }
    }
}

struct SubscriberView: View {
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        Text("\(vm.count)")
            .font(.largeTitle)
    }
}

#Preview {
    SubscriberView()
}

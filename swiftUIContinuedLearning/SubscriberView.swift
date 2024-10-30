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
    
    var cancellable = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textFieldIsValid: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
    }
    
    func addTextFieldSubscriber() -> Void {
        
        $textFieldText.map { text in
            return text.count > 3
        }
        .assign(to: \.textFieldIsValid, on: self)
        .store(in: &cancellable)
    
    }
    
    func setUpTimer() -> Void {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                
                self.count += 1
                
            }
            .store(in: &cancellable)
    }
}

struct SubscriberView: View {
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textFieldIsValid.description)
            
            TextField("type something here...", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    SubscriberView()
}

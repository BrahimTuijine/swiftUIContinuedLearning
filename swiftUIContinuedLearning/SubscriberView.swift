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
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() -> Void {
        
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text in
                return text.count > 3
            }
            .sink(receiveValue: { [weak self] value in
                self?.textFieldIsValid = value
                self?.showButton = value
            })
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
    
    func addButtonSubscriber() -> Void {
        $textFieldIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else {return}
                
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
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
            
//            Text(vm.textFieldIsValid.description)
            
            TextField("type something here...", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    Group {
                        if vm.textFieldIsValid {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .padding(.trailing)
                        } else {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                        
                    }
                        .font(.headline)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                )
            
                Button(action: {}, label: {
                   Text("submit".uppercased())
                       .font(.headline)
                       .foregroundColor(.white)
                       .frame(height: 55)
                       .frame(maxWidth: .infinity)
                       .background(.blue)
                       .cornerRadius(10)
                       .opacity(vm.showButton ? 1 : 0.5)
               })
               .disabled(!vm.showButton)
            
        }
        .padding()
    }
}

#Preview {
    SubscriberView()
}

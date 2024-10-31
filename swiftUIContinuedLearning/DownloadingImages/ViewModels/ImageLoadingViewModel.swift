//
//  ImageLoadingViewModel.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import Foundation
import SwiftUI
import Combine


class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    private var cancellable = Set<AnyCancellable>()
    
    let manager = PhotoModelCacheManager.instance
    
    let imageLink: String
    
    init(imageLink: String) {
        self.imageLink = imageLink
        getImage()
    }
    
    
    func getImage() -> Void {
        if let  localImage = manager.get(name: imageLink) {
            image = localImage
            print("getted from cache")
        } else {
            downloadImage()
            print("download image ")
        }
    }
    
    
    func downloadImage() -> Void {
        print("download image now")
        isLoading = true
        
        guard let url = URL(string: imageLink) else {
            isLoading = false
            return }
        
        URLSession.shared.dataTaskPublisher (for: url)
            .receive(on: DispatchQueue.main)
            .map{ UIImage(data: $0.data) }
            .sink  { [weak self] error in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let image = returnedImage
                else { return }
                
                self.image = image
                self.manager.add(image: image, name: imageLink)
                
            }
            .store(in: &cancellable)
    }
    
}

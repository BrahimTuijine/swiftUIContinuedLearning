//
//  PhotoModelDataService.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import Foundation
import Combine

class PhotoModelDataService {
    static let instance = PhotoModelDataService()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var photoModel: [PhotoModel] = []
    
    private init() {
        downloadData()
    }
    
    // completion: (_ photo: [PhotoModel]) -> Void
    func downloadData() -> Void {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] photo in
                self?.photoModel = photo
            }
            .store(in: &cancellable)
        
    }
}

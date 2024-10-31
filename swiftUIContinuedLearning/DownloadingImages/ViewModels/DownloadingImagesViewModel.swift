//
//  DownloadingImagesViewModel.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import Foundation
import Combine


class PhotoModelViewModel: ObservableObject {
    static let instance = PhotoModelViewModel()
    let dataService = PhotoModelDataService.instance
    private var cancellable = Set<AnyCancellable>()
    
    @Published var photoModel: [PhotoModel] = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() -> Void {
        dataService.$photoModel
            .sink { [weak self] photoModel in
                self?.photoModel = photoModel
        }.store(in: &cancellable)
    }
}

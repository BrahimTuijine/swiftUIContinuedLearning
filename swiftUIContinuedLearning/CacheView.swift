//
//  CacheView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager() 
    
    private init() {
        
    }
    
    var imageCache : NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100Mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> Void {
        imageCache.setObject(image, forKey: name as NSString)
        print("added to Cache")
    }
    
    func remove( name: String) -> Void {
        imageCache.removeObject(forKey: name as NSString)
        print("removed from Cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}


class CacheViewModel: ObservableObject {
    
    let cacheManager: CacheManager = CacheManager.instance
    let imageName: String = "eric"
    
    @Published var image: UIImage? = nil
    @Published var cacheImage: UIImage? = nil
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() -> Void {
        image = UIImage(named: imageName)
    }
    
    func saveToCache() -> Void {
        guard let image = image else { return }
        cacheManager.add(image: image, name: imageName)
    }
    
    func removeFromCache() -> Void {
        cacheManager.remove(name: imageName)
    }
    
    func getFromCache() -> Void {
        cacheImage = cacheManager.get(name: imageName)
    }
}


struct CacheView: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue.cornerRadius(10))
                    })
                    
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Del from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red.cornerRadius(10))
                    })
                    
                }
                
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green.cornerRadius(10))
                })
                
                if let image = vm.cacheImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("File manager")
            
        }
    }
}

#Preview {
    CacheView()
}

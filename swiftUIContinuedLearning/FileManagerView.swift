//
//  FileManagerView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 30/10/2024.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) -> Void {
        

        guard
            // encode the image
            let data : Data = image.pngData(),
            let path = getPathForImage(name:  name)
        else {
            print("error getting data")
            return
        }
        
        
        // save the image
        do {
            try data.write(to: path)
            print("success saving image")
        } catch {
            print("error when saving image \(error.localizedDescription)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            print("error get path") ; return nil }
        
        return UIImage(contentsOfFile: path)
    }
    
    
    
    func deleteImage(name: String) -> Void {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else { print("error get path"); return }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("success delete image")
        } catch {
            print("error when delete image")
        }
        
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            // choose path type
            let path  = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
                // concatinate imageName and path => path/imageName
                .appendingPathComponent("\(name).png")
        else {
            print("error getting path")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    let imageName: String = "eric"
    let fileManager = LocalFileManager.instance
    @Published var image: UIImage? = nil
    
    init() {
//        getImageFromAssetsFolder()
        getImageFromFileManager()
    }
    
    
    func saveImage() -> Void {
        guard let image = image else {return}
        
        fileManager.saveImage(image: image, name: imageName)
    }
    
    
    
    func getImageFromAssetsFolder() -> Void {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() -> Void {
        image = fileManager.getImage(name: imageName)
    }
    
    func deleteImageFromFileManager() -> Void {
        fileManager.deleteImage(name: imageName)
    }
    
}

struct FileManagerView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
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
                
                Button(action: {
                    vm.saveImage()
                }, label: {
                    Text("Save to FM")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue.cornerRadius(10))
                })
                
                Button(action: {
                    vm.deleteImageFromFileManager()
                }, label: {
                    Text("Delete from FM")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue.cornerRadius(10))
                })
                
                Spacer()
            }
            .navigationTitle("File manager")
            
        }
    }
}

#Preview {
    FileManagerView()
}

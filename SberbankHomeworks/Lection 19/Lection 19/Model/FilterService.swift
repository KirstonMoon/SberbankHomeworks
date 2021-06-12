//
//  Filter.swift
//  Lection 19
//
//  Created by Kirill Magerya on 12.06.2021.
//

import UIKit

struct FilterService {
    
    private let context = CIContext()
    
    let filters = CIFilter.filterNames(inCategory: kCICategoryBuiltIn).filter {
        CIFilter(name: $0)?.inputKeys.contains(kCIInputIntensityKey) ?? false
    }
    
    func filterImage(filter: String, image: UIImage, intensity: CGFloat?) -> UIImage {
        guard let filter = CIFilter(name: filter),
              let imageToFilter = CIImage(image: image) else { return UIImage() }
        
        filter.setValue(imageToFilter, forKey: kCIInputImageKey)
        filter.setValue(intensity ?? 0.5, forKey: kCIInputIntensityKey)
        
        guard let filteredImage = filter.outputImage,
              let imageContext = context.createCGImage(filteredImage,
                                                       from: filteredImage.extent) else { return UIImage()}
        
        return UIImage(cgImage: imageContext)
    }
}


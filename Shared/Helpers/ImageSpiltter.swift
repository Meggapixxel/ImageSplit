//
//  ImageSpiltter.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import SwiftUI

struct ImageSpiltter {
    let image: NSImage
    
    func splitted(horizontal value: Int) -> [NSImage] {
        if let cgImage = image.cgImage {
            let images = Int((Double(cgImage.width) / Double(value)).rounded(.up))
            return (0..<images).compactMap { i -> NSImage? in
                if let imageI = cgImage.cropping(
                    to: CGRect(
                        x: i * value,
                        y: 0,
                        width: value,
                        height: cgImage.height
                    )
                ) {
                    return NSImage(cgImage: imageI, size: NSSize(width: value, height: cgImage.height))
                } else {
                    return nil
                }
            }
        } else {
            return []
        }
    }
    
    func splitted(vertical value: Int) -> [NSImage] {
        if let cgImage = image.cgImage {
            let images = Int((Double(cgImage.height) / Double(value)).rounded(.up))
            return (0..<images).compactMap { i -> NSImage? in
                if let imageI = cgImage.cropping(
                    to: CGRect(
                        x: 0,
                        y: i * value,
                        width: cgImage.width,
                        height: value
                    )
                ) {
                    return NSImage(cgImage: imageI, size: NSSize(width: cgImage.width, height: value))
                } else {
                    return nil
                }
            }
        } else {
            return []
        }
    }
    
    
    func splitted(size value: SplitSize) -> [NSImage] {
        if let cgImage = image.cgImage {
            let horizontalImages = Int((Double(cgImage.width) / Double(value.width)).rounded(.up))
            let vericalImages = Int((Double(cgImage.height) / Double(value.height)).rounded(.up))
            return (0..<horizontalImages).map { x -> [NSImage] in
                (0..<vericalImages).compactMap { y -> NSImage? in
                    if let imageI = cgImage.cropping(
                        to: CGRect(
                            x: x * value.width,
                            y: y * value.height,
                            width: value.width,
                            height: value.height
                        )
                    ) {
                        return NSImage(cgImage: imageI, size: NSSize(width: value.width, height: value.height))
                    } else {
                        return nil
                    }
                }
            }.flatMap { $0 }
        } else {
            return []
        }
    }
}

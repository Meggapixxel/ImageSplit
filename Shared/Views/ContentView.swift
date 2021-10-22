//
//  ContentView.swift
//  Shared
//
//  Created by v.zhydenko on 21.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var splitType: SplitType = .vertical
    @State private var activeSplitType: SplitType = .vertical
    @State private var splitSize: SplitSize = .zero
    @State private var imageUrl: URL?
    @State private var splittedImages: [IdentifiableImage] = []
    
    private var isProcessAvailable: Bool {
        switch splitType {
        case .vertical, .horizontal:
            return splitSize.width > 0 || splitSize.height > 0
        case .size:
            return splitSize.width > 0 && splitSize.height > 0
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            SplitTypePickerView(splitType: $splitType, size: $splitSize)
                .padding(.horizontal)
                .padding(.top)
                .onChange(of: splitType) { _ in
                    splitSize = .zero
                    splittedImages = []
                }
            
            DroppableSplitSourceView(imageUrl: $imageUrl)
            
            Group {
                if let imageUrl = imageUrl, isProcessAvailable {
                    VStack(spacing: 20) {
                        Button("Process") {
                            activeSplitType = splitType
                            
                            let images: [NSImage]
                            switch splitType {
                            case .vertical:
                                images = ImageSpiltter(image: NSImage(byReferencing: imageUrl)).splitted(vertical: splitSize.height)
                            case .horizontal:
                                images = ImageSpiltter(image: NSImage(byReferencing: imageUrl)).splitted(horizontal: splitSize.width)
                            case .size:
                                images = ImageSpiltter(image: NSImage(byReferencing: imageUrl)).splitted(size: splitSize)
                            }
                            splittedImages = images.map { IdentifiableImage(id: UUID(), image: $0) }
                        }
                        .frame(height: 60)
                        
                        if splittedImages.count > 0 {
                            HStack {
                                SplittedImagesView(splittedImages: splittedImages)
                                
                                Button("Export") {
                                    // TODO
                                }
                                .padding(.trailing)
                            }
                            .frame(height: 120)
                        } else {
                            Spacer()
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .frame(height: 60 + 120 + 20)
        }
        .frame(minWidth: 600, minHeight: 800)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

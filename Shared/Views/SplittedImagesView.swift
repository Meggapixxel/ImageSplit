//
//  SplittedImagesView.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import SwiftUI

struct SplittedImagesView: View {
    let splittedImages: [IdentifiableImage]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(alignment: .center) {
                    ForEach(splittedImages) { image in
                        Image(nsImage: image.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.height * 3 / 4, height: proxy.size.height)
                            .clipped()
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

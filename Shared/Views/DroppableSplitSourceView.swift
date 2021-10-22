//
//  DroppableSplitSourceView.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import SwiftUI

struct DroppableSplitSourceView: View {
    @Binding var imageUrl: URL?
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Text("Drop image here")
                
                Image(nsImage: imageUrl != nil ? NSImage(byReferencing: imageUrl!) : NSImage())
                    .resizable()
                    .scaledToFit()
                    .onDrop(of: ["public.file-url"], delegate: SingleImageDropDelegate(imageUrl: $imageUrl))
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

private struct SingleImageDropDelegate: DropDelegate {
    let type: String = "public.file-url"
    
    @Binding var imageUrl: URL?
    
    func validateDrop(info: DropInfo) -> Bool {
        info.hasItemsConforming(to: [type])
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: [type]).first {
            item.loadItem(forTypeIdentifier: type, options: nil) { (urlData, error) in
                DispatchQueue.main.async {
                    if let urlData = urlData as? Data {
                        self.imageUrl = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                    }
                }
            }
            return true
        } else {
            return false
        }
    }
}

//
//  IdentifiableImage.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import SwiftUI

struct IdentifiableImage: Identifiable {
    let id: UUID
    let image: NSImage
}

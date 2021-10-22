//
//  SplitSize.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import Foundation

struct SplitSize: Equatable {
    var width: Int
    var height: Int
}

extension SplitSize {
    static var zero: Self { .init(width: 0, height: 0) }
}

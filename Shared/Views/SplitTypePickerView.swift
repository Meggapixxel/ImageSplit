//
//  SplitTypePickerView.swift
//  ImageSplit (macOS)
//
//  Created by v.zhydenko on 22.10.2021.
//

import SwiftUI

struct SplitTypePickerView: View {
    @Binding var splitType: SplitType
    @Binding var size: SplitSize
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            Picker(selection: $splitType, label: Text("Split:")) {
                Text("Vertical").tag(SplitType.vertical)
                Text("Horizontal").tag(SplitType.horizontal)
                Text("Size").tag(SplitType.size)
            }
            .pickerStyle(RadioGroupPickerStyle())
            
            switch splitType {
            case .horizontal:
                TextField("Width", value: $size.width, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            case .vertical:
                TextField("Height", value: $size.height, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            case .size:
                VStack {
                    TextField("Width", value: $size.width, formatter: formatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Height", value: $size.height, formatter: formatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
}

//
//  View+Extensions.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

extension View {
    /// View Alignments
    @ViewBuilder
    func hSpacing(_ aligment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: aligment)
    }
    @ViewBuilder
    func vSpacing(_ aligment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: aligment)
    }
    
    /// disable with opacity
    @ViewBuilder
    func disableWithOpacity(_ condition : Bool)->some View {
        
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
    
}

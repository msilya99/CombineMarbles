//
//  MarbleView.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation
import SwiftUI

struct Marble: View {
    var content: String? = nil

    var body: some View {
        Circle()
            .frame(width: 36, height: 36)
            .foregroundColor(.primary)
            .overlay(Text(content ?? "")
                .padding(2)
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .colorInvert())
    }
}

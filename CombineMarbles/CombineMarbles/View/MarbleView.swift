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
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.primary)
            Text(content ?? "")
                .foregroundColor(.white)
                .font(.system(size: 14))
        }
    }

}

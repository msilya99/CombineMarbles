//
//  FinishedView.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import SwiftUI

private struct FinishedShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

struct Finished: View {
    var body: some View {
        FinishedShape()
            .stroke(lineWidth: 2)
            .stroke(Color.red)
            .foregroundColor(.red)
    }
}

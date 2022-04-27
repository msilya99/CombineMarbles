//
//  DocumentationLink.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import SwiftUI

struct DocumentationLink: View {
    let name: String
    let url: String

    var body: some View {
        if let url = URL(string: url) {
            Link(destination: url) {
                Text(" Documentation for \(self.name)")
                    .lineLimit(1)
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                    .padding(16)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

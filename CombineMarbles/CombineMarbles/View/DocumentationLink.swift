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
                HStack {
                    Text(" Documentation for ") +
                    Text(self.name)
                    Spacer()
                    Image(systemName: "chevron.right")
                }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
        }
    }
}

//
//  ContentView.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import SwiftUI
import Combine

struct ContentView: View {
    let content: [OperatorCollection] = Operators.allCases.map { $0.getOperatorCollection() }

    var body: some View {
        NavigationView {
            List {
                ForEach(content, id: \.name) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.operators, id: \.name) {
                            NavigationLink($0.name, destination: MarblesScreen(operation: $0))
                        }
                    }
                }
            }
            .navigationBarTitle("Operators")
        }
    }
}

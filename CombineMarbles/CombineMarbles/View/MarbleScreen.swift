//
//  MarbleScreen.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import SwiftUI
import Combine

struct MarblesScreen: View {
    @ObservedObject var state: MarbleViewState

    let operation: Operator

    init(operation: Operator) {
        self.operation = operation
        state = operation.state
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 24) {
                ForEach(0..<state.input.count) {
                    MarbleLane(pos: self.$state.input[$0], isDraggable: true)
                        .frame(height: 44)
                }
            }

            Text(operation.description)
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 16).stroke(.foreground))
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)

            MarbleLane(pos: $state.output, isDraggable: false)
                .frame(height: 44)

            DocumentationLink(
                name: self.operation.name,
                url: self.operation.documentationURL
            )
            .padding(.top, 16)
            Spacer()
        }
        .padding(.vertical, 36)
        .padding(.horizontal, 16)
        .navigationBarTitle(operation.name)
        .toolbar { Button("Reset") { self.state.resetToInitionalState() } }
        .onAppear { self.state.update() }
        .onDisappear { self.state.resetToInitionalState() }
    }
}

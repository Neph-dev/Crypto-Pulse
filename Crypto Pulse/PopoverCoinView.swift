//
//  PopoverCoinView.swift
//  Crypto Pulse
//
//  Created by Nephthali Salam on 2023/12/09.
//

import SwiftUI

struct PopoverCoinView: View {
    
    @ObservedObject var viewModel: PopoverCoinViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(viewModel.title).font(.largeTitle)
                Text(viewModel.subtitle).font(.title.bold())
            }
            
            Divider()
            
            Picker("Select Coin", selection: $viewModel.selectedCoinType) {
                ForEach(viewModel.coinTypes) { type in
                    HStack {
                        Text(type.description).font(.headline)
                        Spacer()
                        Text(viewModel.valueText(for: type))
                            .frame(alignment: .trailing)
                            .font(.body)
                        
                        Link(destination: type.url) {
                            Image(systemName: "safari")
                        }
                    }
                    .tag(type)
                }
            }
            .pickerStyle(RadioGroupPickerStyle())
            .labelsHidden()
            
            Divider()
            
            Button("Quit") {
                NSApp.terminate(self)
            }
        }
        .onChange(of: viewModel.selectedCoinType) {_ in viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}

#Preview {
    PopoverCoinView(
        viewModel: .init(title: "Bitcoin", subtitle: "$40,000")
    )
}

//
//  MenuBarCoinView.swift
//  Crypto Pulse
//
//  Created by Nephthali Salam on 2023/12/09.
//

import SwiftUI

struct MenuBarCoinView: View {
    
    @ObservedObject var viewModel: MenuBarCoinViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "circle.fill")
                .foregroundColor(viewModel.color)
            
            VStack(alignment: .trailing, spacing: -2) {
                Text(viewModel.name)
                Text(viewModel.value)
            }
            .font(.caption)
        }
        .onChange(of: viewModel.selectedCoinType) { oldState, newState in viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}

#Preview {
    MenuBarCoinView(viewModel: .init(
        name: "Bitcoin",
        value: "$40,000",
        color: .green
    ))
}

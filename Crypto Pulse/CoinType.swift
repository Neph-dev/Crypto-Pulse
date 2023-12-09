//
//  CoinType.swift
//  Crypto Pulse
//
//  Created by Nephthali Salam on 2023/12/09.
//

import Foundation

enum CoinType: String, Identifiable, CaseIterable {
    case bitcoin
    case ethereum
    case litecoin
    case monero
    case dogecoin
    
    var id: Self { self }
    var url: URL { URL(string: "https://coincap.io/assets/\(rawValue)")! }
    var description: String { rawValue.capitalized }
}

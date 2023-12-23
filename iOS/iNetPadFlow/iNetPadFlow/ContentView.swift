//
//  ContentView.swift
//  iNetPadFlow
//
//  Created by Robert Sale on 12/20/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameControllerManager = GameControllerManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(gameControllerManager.connectedGamepads, id: \.vendorName) { pad in
                    Text(pad.vendorName ?? "Unknown Controller")
                        .onTapGesture {
                            gameControllerManager.selectedGamepad = pad
                        }
                }
                .navigationTitle("iNetPadFlow")
            }
        }
    }
}

#Preview {
    ContentView()
}

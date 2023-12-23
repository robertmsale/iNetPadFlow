//
//  GameControllerManager.swift
//  iNetPadFlow
//
//  Created by Robert Sale on 12/22/23.
//

import Foundation
import SwiftUI
import GameController

class GameControllerManager : ObservableObject {
    @Published var connectedGamepads: [GCController] = []
    @Published var selectedGamepad: GCController?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDidConnect), name: .GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDidDisconnect), name: .GCControllerDidDisconnect, object: nil)
        updateConnectedGamepads()
    }
    
    private func updateConnectedGamepads() {
        connectedGamepads = GCController.controllers().map { $0 }
        
        if selectedGamepad == nil, let firstGamepad = connectedGamepads.first {
            selectGamepad(firstGamepad)
        }
    }
    
    @objc private func controllerDidConnect(notification: Notification) {
        updateConnectedGamepads()
    }
    
    @objc private func controllerDidDisconnect(notification: Notification) {
        updateConnectedGamepads()
    }
    
    func selectGamepad(_ gamepad: GCController) {
        selectedGamepad = gamepad
    }
}

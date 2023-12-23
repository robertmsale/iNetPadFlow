//
//  NetworkBrowser.swift
//  iNetPadFlow
//
//  Created by Robert Sale on 12/22/23.
//

import Foundation
import SwiftUI
import Network

class NetworkBrowser: ObservableObject {
    private var browser: NWBrowser?
    @Published var discoveredServices = [NWEndpoint]()
    
    init() {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        let descriptor = NWBrowser.Descriptor.bonjour(type: "_inetpadflowhost._tcp", domain: "local.")
        browser = NWBrowser(for: descriptor, using: parameters)
    }
    
    func startBrowsing() {
        browser?.stateUpdateHandler = { newState in
            print("Browser state: \(newState)")
        }
        
        browser?.browseResultsChangedHandler = { results, changes in
            Task {
                self.discoveredServices = results.map { $0.endpoint }
            }
        }
        
        browser?.start(queue: DispatchQueue.global(qos: .background))
    }
    
    func stopBrowsing() {
        browser?.cancel()
    }
    
    
}

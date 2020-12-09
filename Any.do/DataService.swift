//
//  DataService.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import Foundation
import Starscream

class DataService {
    
    struct consts {
        static let apiUrl: String = "ws://superdo-groceries.herokuapp.com/receive"
    }

    public static let shared = DataService()
    var isConnected = false
    var socket: WebSocket? = nil
    var onNewData: ((Grocery) ->())? = nil
    
    func startSocket() {
        var request = URLRequest(url: URL(string: consts.apiUrl)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func end() {
        socket?.disconnect()
    }
}

extension DataService: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            let jsonData = Data(string.utf8)
            let decoder = JSONDecoder()
            do {
                let grocery = try decoder.decode(Grocery.self, from: jsonData)
                onNewData?(grocery)
                //                    print(grocery)
            } catch {
                print(error.localizedDescription)
            }
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
        //                handleError(error)
        }
    }
}

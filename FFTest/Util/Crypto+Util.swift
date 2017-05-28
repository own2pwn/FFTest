//
//  Crypto+Util.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import CryptoSwift

typealias APICredentials = (ts: String, key: String, hash: String)

class Encrypt {
    
    private var timestamp: String {
        
        return String(Date.timeIntervalSinceReferenceDate)
    }
    
    private var publicKey: String = "54c685c2d88610c15ada7d4dd9c298f8"
    private var privateKey: String = "8bcac2aa1d363b1c506bb88da31cc58ddf29d266"
    
    private func hash(keys: String) -> String? {
        
        return keys.md5()
    }
    
    func credentials() -> APICredentials?  {
        
        let time = timestamp
        
        guard let hashed = hash(keys: time + privateKey + publicKey) else {
            return nil
        }
        
        return APICredentials(ts: time, key: publicKey, hash: hashed)
    }
}

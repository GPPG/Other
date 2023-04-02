//
//  Collection+Random.swift
//  Predictor
//
//  Created by Jason Wu on 2019/5/9.
//

import Foundation

extension Collection {
    
    var random : Element? {
        guard !isEmpty else { return nil }
        let offset = arc4random_uniform(numericCast(self.count))
        let idx = self.index(self.startIndex, offsetBy: numericCast(offset))
        return self[idx]
    }
    
    func random(_ count : UInt) -> [Element] {
        let sampleCount = Swift.min(numericCast(count), self.count)
        
        var elements = Array(self)
        var samples : [Element] = []
        
        while samples.count < sampleCount {
            let idx = (0..<elements.count).random!
            samples.append(elements.remove(at: idx))
        }
        
        return samples
    }
}

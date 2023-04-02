//
//  Array<GPUFilter>.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/31.
//

import Foundation

extension Array where Element: GPUFilter{
    func findLut() -> LookupFilter?{
        for f in self{
            if f is LookupFilter{
                return (f as! LookupFilter)
            }
        }
        return nil
    }
}

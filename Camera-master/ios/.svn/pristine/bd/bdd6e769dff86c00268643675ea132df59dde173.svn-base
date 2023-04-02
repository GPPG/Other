//
//  MoyaResponse.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/27.
//  Copyright © 2019年 PJ. All rights reserved.
//

import Foundation
import Moya

extension Response{
    func mapCodableModel<T: Codable>(_ type: T.Type) -> T?{
        let result = try? JSONDecoder().decode(type, from: self.data)
        return result
    }
}

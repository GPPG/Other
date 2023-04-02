//
//  MoyaProvider.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/27.
//  Copyright © 2019年 PJ. All rights reserved.
//

import Foundation
import Moya

public extension MoyaProvider{
    /**
     使用分离的成功失败回调代替Completion
     */
    @discardableResult
    func request(_ target: Target,
                      callbackQueue: DispatchQueue? = .none,
                      progress: ProgressBlock? = .none,
                      success: @escaping (Response) -> Void,
                      failure: @escaping (Error) -> Void) -> Cancellable {
        let completion : Completion = { result in
            switch result{
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
        return requestNormal(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }
}


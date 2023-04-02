//
//  Httpbin.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/31.
//

import Foundation
import Moya

//这个方法只是用来在开启应用的时候，在国行机子上请求网络授权
public class HttpbinApi{
    static func testGet(){
        httpbinProvider.request(.get) { (result) in

        }
    }
}

fileprivate let httpbinProvider = MoyaProvider<HttpBin>()

fileprivate enum HttpBin{
    case get
}

extension HttpBin: TargetType{
    public var baseURL: URL{
        return URL.init(string: "https://httpbin.org")!
    }

    public var path: String{
        switch self {
        case .get: return "/get"
        }
    }

    public var method: Moya.Method{
        return .get
    }

    public var task: Task{
        return .requestPlain
    }

    public var sampleData: Data{
        return Data.init()
    }

    public var validationType: ValidationType{
        return .successCodes
    }

    public var headers: [String : String]?{
        return nil
    }
}

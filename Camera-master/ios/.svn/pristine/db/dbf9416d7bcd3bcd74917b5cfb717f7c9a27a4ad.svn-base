//
//  FacePlusPlusApi.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/26.
//  Copyright © 2019年 PJ. All rights reserved.
//

import Foundation
import Moya

typealias FPPDetectCompletition = (FPPDetect?) -> Void

public class FacePlusPlusApi{
    /** 识别人脸并返回特征点与头部姿态 */
    static func detectFace(_ image: UIImage, complete: FPPDetectCompletition?){
        facePlusPlusProvider.request(.detectLandmarkAndAngle(image)) { result in
            switch result{
            case .success(let response):
                let res = response.mapCodableModel(FPPDetect.self)
                complete?(res)
            case .failure(let error):
                print(error)
                complete?(nil)
            }
        }
    }
}

fileprivate let facePlusPlusProvider = MoyaProvider<FacePlusPlus>()

fileprivate enum FacePlusPlus{
    /**
     检测图片基础信息
     */
    case detect(_ image: UIImage)
    case detectLandmarkAndAngle(_ image: UIImage)
    case detectAllAttributes(_ image: UIImage)
}

extension FacePlusPlus: TargetType{
    public var baseURL: URL{
        return URL.init(string: "https://api-cn.faceplusplus.com")!
    }

    public var path: String{
        switch self {
        case .detect, .detectAllAttributes, .detectLandmarkAndAngle:
            return "/facepp/v3/detect"
        }
    }

    public var method: Moya.Method{
        return .post
    }

    public var task: Task{
        var formData :[MultipartFormData] = []
        //共用的key部分
        let sharedData = [
            "api_key":Product.FacePlusKey,
            "api_secret":Product.FacePlusSecret,
            ]
        for (key,value) in sharedData{
            formData.append(MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key))
        }

        //共用的文件上传参数
        switch self {
        case let .detect(image),
             let .detectLandmarkAndAngle(image),
             let .detectAllAttributes(image):
            formData.append(MultipartFormData(provider: .data(image.jpegData(compressionQuality: 0.1)!), name: "image_file", fileName: "file.jpeg", mimeType: "image/jpeg"))
        }

        //不同api使用的不同参数
        switch self {
        case .detectLandmarkAndAngle:
            let privateData = [
                "return_landmark":"2",
                "return_attributes":"headpose"
            ]
            for (key,value) in privateData{
                formData.append(MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key))
            }
        case .detectAllAttributes:
            let privateData = [
                "return_landmark":"2",
                "return_attributes":"gender,age,smiling,headpose,facequality,blur,eyestatus,emotion,ethnicity,beauty,mouthstatus,eyegaze,skinstatus",
            ]
            for (key,value) in privateData{
                formData.append(MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key))
            }
        default:
            break
        }

        return .uploadMultipart(formData)

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

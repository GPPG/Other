//
//  FacePlusPlusModel.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/26.
//  Copyright © 2019年 PJ. All rights reserved.
//

import Foundation
import UIKit


/**
 Face++人脸检测结果
 */
typealias FPPDetect = FPPModel.Detect.Result

/**
 是FacePlusPlus的意思
 */
enum FPPModel{
    enum Detect{
        struct Result: Codable {
            let requestID: String
            let imageID: String?
            let timeUsed: Int
            let faces: [Face]?
            let errorMsg: String?

            enum CodingKeys: String, CodingKey {
                case imageID = "image_id"
                case requestID = "request_id"
                case timeUsed = "time_used"
                case errorMsg = "error_message"
                case faces
            }
        }

        struct Face: Codable {
            let landmark: [String: Landmark]?
            let attributes: Attributes?
            let faceRectangle: FaceRectangle
            let faceToken: String

            enum CodingKeys: String, CodingKey {
                case landmark, attributes
                case faceRectangle = "face_rectangle"
                case faceToken = "face_token"
            }

//          用于生成固定部位图片的方法，这个项目暂时不用
//            enum Part {
//                case Eyes
//                case LeftEye
//                case RightEye
//                case Nose
//                case Mouth
//            }
//
//            func CGRectFrom(_ part: Part) -> CGRect?{
//                guard self.landmark?.count ?? 0 > 100 else{//处于100点模式
//                    return nil
//                }
//                var x, y, width, height: Int
//                let mark = landmark!
//                switch part {
//                case .Eyes:
//                    typealias Point = FPPModel.KeyDefine.Landmark.Eyes
//                    x = mark[Point.Left.leftCorner]!.x
//                    y = [mark[Point.Left.top]!.y, mark[Point.Right.top]!.y].min()!
//                    width = mark[Point.Right.rightCorner]!.x - mark[Point.Left.leftCorner]!.x
//                    let toppest = y
//                    let lowest = [mark[Point.Left.bottom]!.y, mark[Point.Right.bottom]!.y].max()!
//                    height = lowest - toppest
//
//                case .LeftEye:
//                    typealias Point = KeyDefine.Landmark.Eyes
//                    x = mark[Point.Left.leftCorner]!.x
//                    y = mark[Point.Left.top]!.y
//                    width = mark[Point.Left.rightCorner]!.x - mark[Point.Left.leftCorner]!.x
//                    height = mark[Point.Left.bottom]!.y - mark[Point.Left.top]!.y
//
//                case .RightEye:
//                    typealias Point = KeyDefine.Landmark.Eyes
//                    x = mark[Point.Right.leftCorner]!.x
//                    y = mark[Point.Right.top]!.y
//                    width = mark[Point.Right.rightCorner]!.x - mark[Point.Right.leftCorner]!.x
//                    height = mark[Point.Right.bottom]!.y - mark[Point.Right.top]!.y
//
//                case .Nose:
//                    typealias Point = KeyDefine.Landmark.Nose
//                    x = mark[Point.leftContour3]!.x
//                    y = mark[Point.bridge1]!.y
//                    width = mark[Point.rightContour3]!.x - mark[Point.leftContour3]!.x
//                    height = mark[Point.middleContour]!.y - mark[Point.bridge1]!.y
//
//                case .Mouth:
//                    typealias Point = KeyDefine.Landmark.Mouth
//                    x = mark[Point.leftCorner]!.x
//                    y = mark[Point.upperLipTop]!.y
//                    width = mark[Point.rightCorner]!.x - mark[Point.leftCorner]!.x
//                    height = mark[Point.lowerLipBottom]!.y - mark[Point.upperLipTop]!.y
//                }
//
//                return CGRect.init(x: x, y: y, width: width, height: height)
//            }

            /**
             转换为Face++ SDK返回的106点数组
             */
            var sdkFormLandmark: [CGPoint]?{
                get{
                    if let mark = landmark{
                        return LandmarkUtil.convertApiResultToSdkForm(mark)
                    } else{
                        return nil
                    }
                }
            }
        }

        struct Attributes: Codable {
            let emotion: Emotion?
            let beauty: Beauty?
            let gender: Ethnicity?
            let age: Age?
            let mouthstatus: MouthStatus?
            let glass: Ethnicity?
            let skinstatus: SkinStatus?
            let headpose: HeadPose?
            let blur: Blur?
            let smile: QualityResult?
            let eyestatus: EyeStatus?
            let facequality: QualityResult?
            let ethnicity: Ethnicity?
            let eyegaze: EyeGaze?
        }

        struct Age: Codable {
            let value: Int
        }

        struct Beauty: Codable {
            let femaleScore, maleScore: Double

            enum CodingKeys: String, CodingKey {
                case femaleScore = "female_score"
                case maleScore = "male_score"
            }
        }

        struct Blur: Codable {
            let blurness, motionblur, gaussianblur: QualityResult
        }

        struct QualityResult: Codable {
            let threshold, value: Double
        }

        struct Emotion: Codable {
            let sadness, neutral, disgust, anger: Double
            let surprise, fear, happiness: Double
        }

        struct Ethnicity: Codable {
            let value: String
        }

        struct EyeGaze: Codable {
            let rightEyeGaze, leftEyeGaze: PerEyeGaze

            enum CodingKeys: String, CodingKey {
                case rightEyeGaze = "right_eye_gaze"
                case leftEyeGaze = "left_eye_gaze"
            }
        }

        struct PerEyeGaze: Codable {
            let positionXCoordinate, vectorZComponent, vectorXComponent, vectorYComponent: Double
            let positionYCoordinate: Double

            enum CodingKeys: String, CodingKey {
                case positionXCoordinate = "position_x_coordinate"
                case vectorZComponent = "vector_z_component"
                case vectorXComponent = "vector_x_component"
                case vectorYComponent = "vector_y_component"
                case positionYCoordinate = "position_y_coordinate"
            }
        }

        struct EyeStatus: Codable {
            let leftEyeStatus, rightEyeStatus: PerEyeStatus

            enum CodingKeys: String, CodingKey {
                case leftEyeStatus = "left_eye_status"
                case rightEyeStatus = "right_eye_status"
            }
        }

        struct PerEyeStatus: Codable {
            let normalGlassEyeOpen, noGlassEyeClose: Double
            let occlusion, noGlassEyeOpen: Double
            let normalGlassEyeClose, darkGlasses: Double

            enum CodingKeys: String, CodingKey {
                case normalGlassEyeOpen = "normal_glass_eye_open"
                case noGlassEyeClose = "no_glass_eye_close"
                case occlusion
                case noGlassEyeOpen = "no_glass_eye_open"
                case normalGlassEyeClose = "normal_glass_eye_close"
                case darkGlasses = "dark_glasses"
            }
        }

        struct HeadPose: Codable {
            let yawAngle, pitchAngle, rollAngle: Double

            enum CodingKeys: String, CodingKey {
                case yawAngle = "yaw_angle"
                case pitchAngle = "pitch_angle"
                case rollAngle = "roll_angle"
            }
        }

        struct MouthStatus: Codable {
            let close, surgicalMaskOrRespirator, mouthstatusOpen, otherOcclusion: Double

            enum CodingKeys: String, CodingKey {
                case close
                case surgicalMaskOrRespirator = "surgical_mask_or_respirator"
                case mouthstatusOpen = "open"
                case otherOcclusion = "other_occlusion"
            }
        }

        struct SkinStatus: Codable {
            let darkCircle, stain, acne, health: Double

            enum CodingKeys: String, CodingKey {
                case darkCircle = "dark_circle"
                case stain, acne, health
            }
        }

        struct FaceRectangle: Codable {
            let width, top, left, height: Int

            enum CodingKeys: String, CodingKey {
                case width, top, left, height
            }

            /**
             返回类似70,80,100,100的字符串
             */
            func paramString() -> String{
                return "\(top),\(left),\(width),\(height)"
            }

            func cgRect() -> CGRect{
                return CGRect.init(x: left, y: top, width: width, height: height)
            }
        }

        struct Landmark: Codable {
            let y, x: Int

            var cgPoint: CGPoint{
                get{
                    return CGPoint(x: x, y: y)
                }
            }
        }
    }

    enum Merge {
        struct Result: Codable {
            let timeUsed: Int?
            let requestID: String?
            let result, errorMessage: String?

            enum CodingKeys: String, CodingKey {
                case timeUsed = "time_used"
                case result = "result"
                case requestID = "request_id"
                case errorMessage = "error_message"
            }

            func mergedImage() -> UIImage?{
                guard let resultBase64String = result else{
                    return nil
                }
                let imageData = Data.init(base64Encoded: resultBase64String)
                guard imageData != nil else{
                    return nil
                }
                return UIImage.init(data: imageData!)
            }
        }

    }
}



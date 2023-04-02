//
//  FacePlusPlusKeyDefine.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/28.
//  Copyright © 2019年 PJ. All rights reserved.
//

//  老实说好像没必要用这个

typealias FppKey = FPPModel.KeyDefine
extension FPPModel{
    enum KeyDefine {
        enum Landmark{
            enum Eyes{
                case Left
                case Right
                private var eyeName :String{
                    switch self {
                    case .Left:
                        return "left_eye_"
                    case .Right:
                        return "right_eye_"
                    }
                }
                var leftCorner :String { return "\(eyeName)left_corner"}
                var rightCorner :String { return "\(eyeName)right_corner"}
                var top :String { return "\(eyeName)top"}
                var bottom :String { return "\(eyeName)bottom"}
            }

            /**
             83点模式不可用
             */
            enum Nose{
                /**
                 API文档里鼻子最高点
                 */
                static let bridge1 = "nose_bridge1"
                /**
                 API文档里鼻子最低点
                 */
                static let middleContour = "nose_middle_contour"
                /**
                 API文档里鼻子最左点
                 */
                static let leftContour3 = "nose_left_contour3"
                /**
                 API文档里鼻子最右点
                 */
                static let rightContour3 = "nose_right_contour3"
            }

            enum Mouth{
                /**
                 API文档中的最高点
                 */
                static let upperLipTop = "mouth_upper_lip_top"
                /**
                 API文档中的最低点
                 */
                static let lowerLipBottom = "mouth_lower_lip_bottom"
                static let leftCorner = "mouth_left_corner"
                static let rightCorner = "mouth_right_corner"

            }

        }
    }
}

//
//  LandmarkUtil.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/31.
//

import Foundation

class LandmarkUtil{
    static func convertApiResultToSdkForm(_ mark: [String: FPPModel.Detect.Landmark]) -> [CGPoint]{
        func getPointOrZero(_ key: String) -> CGPoint{
            return mark[key]?.cgPoint ?? CGPoint.zero
        }
        var points: [CGPoint] = []

        //0-15
        for i in [Int](1...16){
            let key = "contour_left\(i)"
            points.append(getPointOrZero(key))
        }
        //16
        points.append(getPointOrZero("contour_chin"))
        //17-32



        for i in [Int](1...16).reversed(){
            let key = "contour_right\(i)"
            points.append(getPointOrZero(key))
        }
        //33-37
        points.append(getPointOrZero("left_eyebrow_left_corner"))
        points.append(getPointOrZero("left_eyebrow_upper_left_quarter"))
        points.append(getPointOrZero("left_eyebrow_upper_middle"))
        points.append(getPointOrZero("left_eyebrow_upper_right_quarter"))
        points.append(getPointOrZero("left_eyebrow_upper_right_corner"))
        //38-42
        points.append(getPointOrZero("right_eyebrow_upper_left_corner"))
        points.append(getPointOrZero("right_eyebrow_upper_left_quarter"))
        points.append(getPointOrZero("right_eyebrow_upper_middle"))
        points.append(getPointOrZero("right_eyebrow_upper_right_quarter"))
        points.append(getPointOrZero("right_eyebrow_right_corner"))
        //43-46
        points.append(getPointOrZero("nose_bridge1"))
        points.append(getPointOrZero("nose_bridge2"))
        points.append(getPointOrZero("nose_bridge3"))
        points.append(getPointOrZero("nose_tip"))
        //47-51
        points.append(getPointOrZero("nose_left_contour4"))
        points.append(getPointOrZero("nose_left_contour5"))
        points.append(getPointOrZero("nose_middle_contour"))
        points.append(getPointOrZero("nose_right_contour5"))
        points.append(getPointOrZero("nose_right_contour4"))
        //52-57
        points.append(getPointOrZero("left_eye_left_corner"))
        points.append(getPointOrZero("left_eye_upper_left_quarter"))
        points.append(getPointOrZero("left_eye_upper_right_quarter"))
        points.append(getPointOrZero("left_eye_right_corner"))
        points.append(getPointOrZero("left_eye_lower_right_quarter"))
        points.append(getPointOrZero("left_eye_lower_left_quarter"))
        //58-63
        points.append(getPointOrZero("right_eye_left_corner"))
        points.append(getPointOrZero("right_eye_upper_left_quarter"))
        points.append(getPointOrZero("right_eye_upper_right_quarter"))
        points.append(getPointOrZero("right_eye_right_corner"))
        points.append(getPointOrZero("right_eye_lower_right_quarter"))
        points.append(getPointOrZero("right_eye_lower_left_quarter"))
        //64-67
        points.append(getPointOrZero("left_eyebrow_lower_left_quarter"))
        points.append(getPointOrZero("left_eyebrow_lower_middle"))
        points.append(getPointOrZero("left_eyebrow_lower_right_quarter"))
        points.append(getPointOrZero("left_eyebrow_lower_right_corner"))
        //68-71
        points.append(getPointOrZero("right_eyebrow_lower_left_corner"))
        points.append(getPointOrZero("right_eyebrow_lower_left_quarter"))
        points.append(getPointOrZero("right_eyebrow_lower_middle"))
        points.append(getPointOrZero("right_eyebrow_lower_right_quarter"))
        //72-74
        points.append(getPointOrZero("left_eye_top"))
        points.append(getPointOrZero("left_eye_bottom"))
        points.append(getPointOrZero("left_eye_center"))
        //75-77
        points.append(getPointOrZero("right_eye_top"))
        points.append(getPointOrZero("right_eye_bottom"))
        points.append(getPointOrZero("right_eye_center"))
        //78-83
        points.append(getPointOrZero("nose_left_contour1"))
        points.append(getPointOrZero("nose_right_contour1"))
        points.append(getPointOrZero("nose_left_contour2"))
        points.append(getPointOrZero("nose_right_contour2"))
        points.append(getPointOrZero("nose_left_contour3"))
        points.append(getPointOrZero("nose_right_contour3"))
        //84-90
        points.append(getPointOrZero("mouth_left_corner"))
        points.append(getPointOrZero("mouth_upper_lip_left_contour2"))
        points.append(getPointOrZero("mouth_upper_lip_left_contour1"))
        points.append(getPointOrZero("mouth_upper_lip_top"))
        points.append(getPointOrZero("mouth_upper_lip_right_contour1"))
        points.append(getPointOrZero("mouth_upper_lip_right_contour2"))
        points.append(getPointOrZero("mouth_right_corner"))
        //91-95
        points.append(getPointOrZero("mouth_lower_lip_right_contour2"))
        points.append(getPointOrZero("mouth_lower_lip_right_contour3"))
        points.append(getPointOrZero("mouth_lower_lip_bottom"))
        points.append(getPointOrZero("mouth_lower_lip_left_contour3"))
        points.append(getPointOrZero("mouth_lower_lip_left_contour2"))
        //96-100
        points.append(getPointOrZero("mouth_upper_lip_left_contour3"))
        points.append(getPointOrZero("mouth_upper_lip_left_contour4"))
        points.append(getPointOrZero("mouth_upper_lip_bottom"))
        points.append(getPointOrZero("mouth_upper_lip_right_contour4"))
        points.append(getPointOrZero("mouth_upper_lip_right_contour3"))
        //101-103
        points.append(getPointOrZero("mouth_lower_lip_right_contour1"))
        points.append(getPointOrZero("mouth_lower_lip_top"))
        points.append(getPointOrZero("mouth_upper_lip_right_contour1"))
        //104-105
        points.append(getPointOrZero("left_eye_pupil"))
        points.append(getPointOrZero("right_eye_pupil"))

        if points.count != 106{
            print("点数转换不足106点")
        }

        return points
    }
}

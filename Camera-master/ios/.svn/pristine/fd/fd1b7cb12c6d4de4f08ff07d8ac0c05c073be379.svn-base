//
//  DFResultViewController.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import Foundation

class DFResultViewController: UIViewController {
    
    static var storyboardName: String = "DailyFortune"
    static var storyboardId: String = "DFResult"
    
    let SUITABLE = ["Diet", "Read", "Cooking", "Watching movie", "Working"]
    let OKAY = ["Hike", "Date", "Propose", "House moving", "Trade", "Exercise", "Hanging out", "Cleaning", "Shopping"]
    let UNSUITABLE = ["Gamble"]
    
    let SCORE_MIN = 60
    let SCORE_MID = 69
    let SCORE_MAX = 99
    
    @IBOutlet weak var overallFortuneLabel: UILabel!
    @IBOutlet weak var profile: RoundImageView!
    @IBOutlet fileprivate var scoreLabels: [UILabel]!
    @IBOutlet fileprivate var suitableLabels: [UIButton]!
    @IBOutlet fileprivate var unsuitableLabels: [UIButton]!
    @IBOutlet weak var radarView: RadarView!
    
    var profileImage: UIImage?
    
    class func show(parent: UIViewController, image: UIImage) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! DFResultViewController
        vc.profileImage = image
        parent.show(vc, sender: nil)
    }

    override func viewDidLoad() {
        
        profile.image = profileImage
        var scores = [Int]()
        var lowerScore = false
        // 60~69区间的分数控制最多出现一次
        for _ in 0..<scoreLabels.count {
            var score = 0
            if lowerScore {
                score = Int.random(in: SCORE_MID...SCORE_MAX)
            } else {
                score = Int.random(in: SCORE_MIN...SCORE_MAX)
            }
            if score <= SCORE_MID && !lowerScore {
                lowerScore = true
            }
            scores.append(score)
        }
            
        let suitables = (SUITABLE + OKAY).random(UInt(suitableLabels!.count))
        let unsuitables = (UNSUITABLE + OKAY).filter({!suitables.contains($0)}).random(UInt(unsuitableLabels!.count))
        
        var totalScore = 0
        for i in 0..<scoreLabels.count {
            let score = scores[i]
            totalScore += score
            scoreLabels[i].text = "\(score)"
        }
        overallFortuneLabel.text = "\(totalScore / scores.count)"
        for i in 0..<suitableLabels.count {
            suitableLabels[i].setTitle(suitables[i], for: .normal)
        }
        for i in 0..<unsuitableLabels.count {
            unsuitableLabels[i].setTitle(unsuitables[i], for: .normal)
        }
        radarView.updateValues(values: Array(scores))
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

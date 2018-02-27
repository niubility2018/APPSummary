//
//  CountDownLabel.swift
//  RuntimeTest
//
//  Created by xubojoy on 2018/1/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class CountDownLabel: UILabel {
    var count: Int = 0
    var timer = Timer.init()
    func startCount(){
        self.initTimer()
    }
    
    func initTimer(){
        if self.count == 0 {
            self.count = 5
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    func countDown(){
        if count > 0 {
            self.text = String.init(format: "%d", count)
            let anima2 = CAKeyframeAnimation.init(keyPath: "transform.scale")
            anima2.values = [NSNumber.init(value: 3.0),NSNumber.init(value: 2.0),NSNumber.init(value: 0.7),NSNumber.init(value: 1.0)]
            anima2.duration = 0.5
            self.layer.add(anima2, forKey: "scalsTime")
            count -= 1
        } else {
            timer.invalidate()
            self.removeFromSuperview()
        }
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

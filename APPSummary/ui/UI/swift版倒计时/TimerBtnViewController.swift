//
//  TimerBtnViewController.swift
//  APPSummary
//
//  Created by xubojoy on 2018/6/4.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class TimerBtnViewController: UIViewController {

    var sendBtn: SendCodeBtn!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        方法一
        
        //        let btn = TimerButton.init(frame:CGRect(x:view.frame.size.width / 2 - 50 , y: 100, width: 100, height: 30))
        //        btn.setup("获取验证码", timeTitlePrefix: "重新发送", aTimeLength: 10)
        //        btn.clickBtnEvent = {
        //            () -> Void in
        //
        //                if !btn.isWorking{
        //
        //                    //访问接口，获取验证码
        //
        //                    btn.isWorking = true
        //                }
        //
        //        }
        //        view.addSubview(btn)
        
        //        方法二
        sendBtn = SendCodeBtn.init(frame:CGRect(x:view.frame.size.width / 2 - 50 , y: 100, width: 100, height: 30))
        sendBtn.setTitle("获取验证码", for: .normal)
        sendBtn.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        self.view.addSubview(sendBtn)
    }
    
    @objc func sendBtnClick(){
        sendBtn.timeFailBeginFrom(10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

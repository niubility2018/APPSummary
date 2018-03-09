//
//  SortViewController.swift
//  APPSummary
//
//  Created by xubojoy on 2018/3/8.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class SortViewController: UIViewController, UITextFieldDelegate {

    var displayView: UIView!
    var numberCountTextField: UITextField!
    var modeMaskView: UIView!
    var segment: UISegmentedControl!
    var sortButton: UIButton!
    
    
    
    var sortViews: Array<SortView> = []
    var sortViewHight: Array<Int> = []
    var sort: SortType! = BubbleSort()
    
    var numberCount: Int = 200
    var displayViewHeight: CGFloat {
        get {
            return displayView.frame.height
        }
    }
    
    var displayViewWidth: CGFloat {
        get {
            return displayView.frame.width
        }
    }
    
    var sortViewWidth: CGFloat {
        get {
            return self.displayViewWidth / CGFloat(self.numberCount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initUI()
        self.setSortClosure()
    }
    
    func initUI() {
        modeMaskView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 114))
        modeMaskView.backgroundColor = UIColor.brown
        self.view.addSubview(modeMaskView)
        
        
        numberCountTextField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 40))
        numberCountTextField.backgroundColor = UIColor.white
        modeMaskView.addSubview(numberCountTextField)
        
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 40))
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 40))
        label.text = "元素个数"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        leftView.addSubview(label)
        numberCountTextField.leftView = leftView
        numberCountTextField.leftViewMode = UITextFieldViewMode.always
        
    
        sortButton = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.width-60-10, y: 0, width: 60, height: 40))
        sortButton.setTitle("排序", for: UIControlState.normal)
        sortButton.backgroundColor = UIColor.brown
        sortButton.addTarget(self, action: #selector(tapSortButton), for: UIControlEvents.touchUpInside)
        modeMaskView.addSubview(sortButton)
        
        //分段选项显示
        let items = ["冒泡","选择","插入","希尔","堆排","归并","快排","基数"]
        
        //初始化对象
        segment = UISegmentedControl(items:items)
        
        segment.frame = CGRect.init(x: 0, y: 40+20, width: UIScreen.main.bounds.width, height: 40)
//        segment.backgroundColor = UIColor.cyan
        
        segment.tintColor = UIColor.black
        
        //设置位置
//        segment.center = modeMaskView.center
        
        //当前选中下标
        segment.selectedSegmentIndex = 0
        
        //添加事件
        segment.addTarget(self, action: #selector(tapSegmentContol), for: UIControlEvents.valueChanged)
        
        //添加
        modeMaskView.addSubview(segment)

        displayView = UIView.init(frame: CGRect.init(x: 0, y: 114+64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-114-64))
        self.view.addSubview(displayView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.numberCountTextField.delegate = self
        self.numberCountTextField.text = "\(numberCount)"
        if sortViews.isEmpty {
            self.configSortViewHeight()
            self.addSortViews()
        }
    }
    
    // MARK: - Response Event
    func tapSegmentContol(_ sender: UISegmentedControl) {
        self.configSortViewHeight()
        for i in 0..<self.sortViews.count {
            self.updateSortViewHeight(index: i, value: CGFloat(sortViewHight[i]))
        }
        
        let sortType = SortTypeEnum(rawValue: sender.selectedSegmentIndex)!
        self.sort = SortFactory.create(type: sortType)
        self.setSortClosure()
    }
    
   func tapSortButton(_ sender: AnyObject) {
        self.modeMaskView.isHidden = false
        DispatchQueue.global().async {
            self.sortViewHight = self.sort.sort(items: self.sortViewHight)
        }
    }
    
    //MARK: -- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text
        guard let number: Int = Int(text!) else {
            return true
        }
        numberCount = number
        self.resetSubViews()
        return true
    }
    
    
    //MARK: - Private Method
    /// 设置排序对象相关的回调
    private func setSortClosure() {
        weak var weak_self = self
        sort.setEveryStepClosure(everyStepClosure: { (index, value) in
            DispatchQueue.main.async {
                weak_self?.updateSortViewHeight(index: index, value: CGFloat(value))
            }
        }) { (list) in
            DispatchQueue.main.async {
//                weak_self?.modeMaskView.isHidden = true
            }
        }
    }
    
    /// 随机生成sortView的高度
    private func configSortViewHeight() {
        if !sortViewHight.isEmpty {
            sortViewHight.removeAll()
        }
        for _ in 0..<self.numberCount {
            self.sortViewHight.append(Int(arc4random_uniform(UInt32(displayViewHeight))))
        }
    }
    
    private func addSortViews() {
        for i in 0..<self.numberCount {
            let size: CGSize = CGSize(width: self.sortViewWidth, height: CGFloat(sortViewHight[i]))
            let origin: CGPoint = CGPoint(x: CGFloat(i) * sortViewWidth, y: 0)
            let sortView = SortView(frame: CGRect(origin: origin, size: size))
            self.displayView.addSubview(sortView)
            self.sortViews.append(sortView)
//            CGRect.init(origin: CGPoint.zero, size: CGSize())
        }
    }
    
    private func updateSortViewHeight(index: Int, value: CGFloat) {
        self.sortViews[index].updateHeight(height: value)
    }
    
    private func resetSubViews()  {
        for subView in self.sortViews  {
            subView.removeFromSuperview()
        }
        self.sortViews.removeAll()
        self.sortViewHight.removeAll()
        self.configSortViewHeight()
        self.addSortViews()
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

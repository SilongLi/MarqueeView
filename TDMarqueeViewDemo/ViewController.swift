//
//  ViewController.swift
//  TDMarqueeViewDemo
//
//  Created by lisilong on 2018/2/28.
//  Copyright © 2018年 tuandai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var marqueeView: TDMarqueeView?
    var scrollView: UIScrollView = {
        let sc = UIScrollView()
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scrollView)
        
        let frame = CGRect(x: 0, y: 300, width: self.view.bounds.size.width, height: 44)
        let title = "每日行情"
        let content = "弃我去者，昨日之日不可留；乱我心者，今日之日多烦忧。团盈基金，团盈基金，团盈基金。"
        marqueeView = TDMarqueeView.init(frame: frame, icon: #imageLiteral(resourceName: "icon"), title: title, content: content, indicator: #imageLiteral(resourceName: "detailIcon"), timeInterval: 10.0)
        marqueeView?.gotoDetailAction {
            print("每日行情 ： 666")
        }
        scrollView.addSubview(marqueeView!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize.init(width: self.view.bounds.size.width, height: self.view.bounds.size.height * 1.3)
        scrollView.frame = self.view.bounds
    }
}


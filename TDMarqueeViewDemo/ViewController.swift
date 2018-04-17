//
//  ViewController.swift
//  TDMarqueeViewDemo
//
//  Created by lisilong on 2018/2/28.
//  Copyright © 2018年 tuandai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var marqueeView0: TDMarqueeView?
    var marqueeView1: TDMarqueeView?
    var marqueeView2: TDMarqueeView?
    var marqueeView3: TDMarqueeView?
    
    var scrollView: UIScrollView = {
        let sc = UIScrollView()
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        
        let title = "每日行情"
        let content = "弃我去者，昨日之日不可留；乱我心者，今日之日多烦忧。团盈基金，团盈基金，团盈基金。"
        
        // 0
        let frame0 = CGRect(x: 0, y: 150, width: self.view.bounds.size.width, height: 44)
        marqueeView0 = TDMarqueeView(frame: frame0,
                                     icon: #imageLiteral(resourceName: "icon"),
                                     title: title,
                                     content: "团盈基金，团盈基金，团盈基金。",
                                     indicator: #imageLiteral(resourceName: "detailIcon"),
                                     timeInterval: 10.0)
        marqueeView0?.titleColor = .red
        marqueeView0?.gotoDetailAction {
            print("每日行情 ： 666")
        }
        scrollView.addSubview(marqueeView0!)
        
        // 1
        let frame1 = CGRect(x: 0, y: 250, width: self.view.bounds.size.width, height: 44)
        marqueeView1 = TDMarqueeView(frame: frame1,
                                     icon: #imageLiteral(resourceName: "icon"),
                                     title: nil,
                                     content: content,
                                     indicator: #imageLiteral(resourceName: "detailIcon"),
                                     timeInterval: 10.0)
        marqueeView1?.gotoDetailAction {
            print("每日行情 ： 666")
        }
        scrollView.addSubview(marqueeView1!)
        
        // 2
        let frame2 = CGRect(x: 0, y: 350, width: self.view.bounds.size.width, height: 44)
        marqueeView2 = TDMarqueeView(frame: frame2,
                                     icon: #imageLiteral(resourceName: "icon"),
                                     title: title,
                                     content: content,
                                     indicator: #imageLiteral(resourceName: "detailIcon"),
                                     timeInterval: 10.0)
        marqueeView2?.titleColor = .red
        marqueeView2?.gotoDetailAction {
            print("每日行情 ： 666")
        }
        scrollView.addSubview(marqueeView2!)
        
        // 3
        marqueeView3 = TDMarqueeView(frame: CGRect(x: 0,
                                                   y: 450,
                                                   width: self.view.bounds.size.width,
                                                   height: 44),
                                    content: content,
                                    timeInterval: 10.0)
        marqueeView3?.titleColor = .red
        marqueeView3?.contentColor = .blue
        marqueeView3?.gotoDetailAction {
            print("每日行情 ： 666")
        }
        scrollView.addSubview(marqueeView3!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize.init(width: self.view.bounds.size.width, height: self.view.bounds.size.height * 1.3)
        scrollView.frame = self.view.bounds
    }
}


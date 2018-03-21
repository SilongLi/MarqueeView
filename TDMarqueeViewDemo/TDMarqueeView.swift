//
//  TDMarqueeView.swift
//  TDMarqueeViewDemo
//
//  Created by lisilong on 2018/2/28.
//  Copyright © 2018年 tuandai. All rights reserved.
//

import UIKit

class TDMarqueeView: UIView {
    /// 图标
    private lazy var iconView: UIImageView = {
        let icon =  UIImageView()
        return icon
    }()
    
    /// 标题
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.textColor = UIColor.red
        title.font = UIFont.systemFont(ofSize: 10)
        return title
    }()
    
    /// 内容
    private lazy var contentView: UIView = {
        let content = UIView()
        return content
    }()
    
    /// 指示器
    private lazy var indicatorView: UIView = {
        let indicator = UIView()
        return indicator
    }()
    
    private lazy var indicatorIconView: UIImageView = {
        let indicator = UIImageView()
        return indicator
    }()
    
    private var title: String?
    private var content: String?
    private var timeInterval: TimeInterval = {
        return TimeInterval.init(5.0)
    }()
    private var firstContentFrame: CGRect = CGRect.zero
    private var secondContentFrame: CGRect = CGRect.zero
    private var contentLabelArray = [UILabel]()
    private var isStop = false
    private var gotoDetailBlock: (() -> ())?
    
    // MARK: - init
    
    /// 初始化“跑马灯”视图方法
    ///
    /// - Parameters:
    ///   - frame: 视图大小
    ///   - icon: 图标(可选)
    ///   - title: 标题(可选)
    ///   - content: “跑马灯”内容
    ///   - indicator: 指示器图标(可选)
    ///   - timeInterval: “跑马灯”动画执行时间
    convenience init(frame: CGRect, icon: UIImage?, title: String?, content: String, indicator: UIImage?, timeInterval: Double = 5.0) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        // 初始化组件
        let merge = 8.0
        var titleX = merge
        if let image = icon {
            let iconW = 15.0
            titleX += iconW + 5.0
            let y = (Double(frame.size.height) - iconW) * 0.5
            iconView.image = image
            iconView.frame = CGRect(x: 10.0, y: y, width: iconW, height: iconW)
            self.addSubview(iconView)
        }
        var contentX = titleX
        if let t = title {
            let titleW = 46.0
            contentX += titleW
            titleLabel.text = t
            titleLabel.frame = CGRect(x: titleX, y: 0.0, width: titleW, height: Double(frame.size.height))
            self.addSubview(titleLabel)
        }
        
        var indicatorViewW = merge
        if let indicatorIcon = indicator {
            indicatorViewW = 20.0
            let indicatorViewX = Double(frame.size.width) - indicatorViewW
            indicatorView.frame = CGRect(x: indicatorViewX, y: 0.0, width: indicatorViewW, height: Double(frame.size.height))
            self.addSubview(indicatorView)
            
            let iconW = 15.0
            let y = (Double(indicatorView.frame.size.height) - iconW) * 0.5
            indicatorIconView.image = indicatorIcon
            indicatorIconView.frame = CGRect(x: 0.0, y: y, width: iconW, height: iconW)
            indicatorView.addSubview(indicatorIconView)
        }
        contentX += 5.0
        let contentW = Double(frame.size.width) - contentX - indicatorViewW
        contentView.frame = CGRect(x: contentX, y: 0.0, width: contentW, height: Double(frame.size.height))
        contentView.clipsToBounds = true
        self.addSubview(contentView)
        
        // 给组件赋值
        self.content = content
        self.timeInterval = timeInterval
        
        let lab = UILabel()
        lab.frame = CGRect.zero
        lab.textColor = UIColor.lightGray
        lab.font = UIFont.systemFont(ofSize: 10.0)
        lab.text = content
        
        // 计算“跑马灯”内容的显示大小
        let sizeOfText = lab.sizeThatFits(CGSize.zero)
        firstContentFrame  = CGRect(x: 0.0, y: 0.0, width: Double(sizeOfText.width), height: Double(frame.size.height))
        secondContentFrame = CGRect(x: Double(firstContentFrame.origin.x+firstContentFrame.size.width) + merge, y: 0.0, width: Double(sizeOfText.width), height: Double(frame.size.height))
        lab.frame = firstContentFrame
        contentView.addSubview(lab)
        contentLabelArray.append(lab)
        
        // 如果一屏幕显示不完全，则添加新的一个lab，并执行动画
        let useReserve = Double(sizeOfText.width) > contentW ? true : false
        if useReserve {
            let lab = UILabel(frame: secondContentFrame)
            lab.textColor = UIColor.lightGray
            lab.font = UIFont.systemFont(ofSize: 10.0)
            lab.text = content;
            contentView.addSubview(lab)
            contentLabelArray.append(lab)
            self.start()
        }
        
        // 添加交互点击手势
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureRecognizer))
        self.addGestureRecognizer(tapGR)
    }
    
    // MARK: - actions
    
    /// 点击“跑马灯”视图事件
    ///
    /// - Parameter action: 点击交互回调
    public func gotoDetailAction(_ action: @escaping (() -> ())) {
        self.gotoDetailBlock = action
    }
    
    /// 开始“跑马灯”动画
    public func start() {
        isStop = false
        // 只有在一个屏幕显示不完全内容的时候，才需要“跑马灯”动画
        guard contentLabelArray.count > 1 else {
            return
        }
        let lbindex0 = contentLabelArray[0]
        let lbindex1 = contentLabelArray[1]
        lbindex0.frame = secondContentFrame
        lbindex1.frame = firstContentFrame
        self.contentLabelArray[0] = lbindex1
        self.contentLabelArray[1] = lbindex0
        
        self.handleContentAnimation()
    }
    
    /// 停止“跑马灯”动画
    public func stop() {
        isStop = true
        self.handleContentAnimation()
    }
    
    /// “跑马灯”动画
    private func handleContentAnimation() {
        guard isStop == false else {
            self.layer.removeAllAnimations()
            return
        }
        // 只有在一个屏幕显示不完全内容的时候，才需要“跑马灯”动画
        guard contentLabelArray.count > 1 else {
            return
        }
        let lbindex0 = contentLabelArray[0]
        let lbindex1 = contentLabelArray[1]
        UIView.transition(with: self, duration: timeInterval, options: .curveLinear, animations: {
            lbindex0.frame = CGRect(x: -self.firstContentFrame.size.width,
                                    y: 0,
                                    width: self.firstContentFrame.size.width,
                                    height: self.firstContentFrame.size.height)
            lbindex1.frame = CGRect(x: lbindex0.frame.origin.x + lbindex0.frame.size.width,
                                    y: 0,
                                    width: lbindex1.frame.size.width,
                                    height: lbindex1.frame.size.height)
            
        }, completion: { finished in
            lbindex0.frame = self.secondContentFrame
            lbindex1.frame = self.firstContentFrame
            self.contentLabelArray[0] = lbindex1
            self.contentLabelArray[1] = lbindex0
            self.handleContentAnimation()
        })
    }
    
    @objc private func tapGestureRecognizer() {
        if let block = self.gotoDetailBlock {
            block()
        }
    }
}

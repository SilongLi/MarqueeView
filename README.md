# MarqueeView

## 介绍
Swift4.0_跑马灯动画，图标、标题和指示器可配置。

> Swift 4.0
> 
>  iOS 8.0 
> 
> Xcode 9.0

## Example

初始化方法

~~~Swift
/// 初始化“跑马灯”视图方法
    ///
    /// - Parameters:
    ///   - frame: 视图大小
    ///   - icon: 图标(可选)
    ///   - title: 标题(可选)
    ///   - content: “跑马灯”内容
    ///   - indicator: 指示器图标(可选)
    ///   - timeInterval: “跑马灯”动画执行时间
    convenience internal init(frame: CGRect, icon: UIImage?, title: String?, content: String, indicator: UIImage?, timeInterval: Double = default)
~~~

交互方法

~~~Swift
/// 点击“跑马灯”视图事件
///
/// - Parameter action: 点击交互回调
public func gotoDetailAction(_ action: @escaping (() -> ()))

/// 开始“跑马灯”动画
public func start()

/// 停止“跑马灯”动画
public func stop()
~~~
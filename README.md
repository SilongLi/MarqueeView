# MarqueeView

## 介绍
Swift4.0_跑马灯动画，图标、标题和指示器可配置。

> Swift 4.0
> 
>  iOS 8.0 
> 
> Xcode 9.0

## Example

可是设置属性

~~~Swift
/// 内容颜色
public var contentTextColor: UIColor { get set }

/// 标题文案颜色
public var titleColor: UIColor { get set }

/// 内容文案颜色
public var contentColor: UIColor { get set }

~~~

初始化方法

~~~Swift
/// 初始化“跑马灯”视图方法
///
/// - Parameters:
///   - frame: 视图大小
///   - content: “跑马灯”内容
///   - contentTextFont: “跑马灯”内容字体大小
///   - isContentCenter: 是否居中
///   - timeInterval: “跑马灯”动画执行时间
convenience internal init(frame: CGRect, content: String, contentTextFont: UIFont = default, isContentCenter: Bool = default, timeInterval: Double)

/// 初始化“跑马灯”视图方法
///
/// - Parameters:
///   - frame: 视图大小
///   - icon: 图标
///   - title: 标题
///   - content: “跑马灯”内容
///   - indicator: 指示器图标
///   - timeInterval: “跑马灯”动画执行时间
convenience internal init(frame: CGRect, icon: UIImage?, title: String?, titleTextFont: UIFont? = default, content: String, contentTextFont: UIFont = default, indicator: UIImage?, timeInterval: Double = default, isContentCenter: Bool = default)
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
# -Usage-of-UITabBarButton-
你所不知道的UITabBarButton?  UITabBarButton的相关介绍,已经通过新浪微博实例验证tabBar中间按钮的创建

##阐述:
只要有一定开发经验的iOS攻城狮,只要你做过应用程序APP的开发,不可避免的都会用到UITabBarController, UITabBarController又称标签控制器 ,同样是管理多控制器的,我们一般的做法都是将多个(一般是4-6个之间)UINavigationController作为UITabBarController的子控件,添加到UITabBarController的导航标签栏(也叫工具条)UITabBar上;

今天在这里,我要讲的,不是怎样创建一个UITabBarController,因为,这个比较简单,也是每个iOS攻城狮所需要必备的技能,那么问题来了,今天,我要说什么呢 ?  

细心的朋友估计已经看出来了, 没错, 我要讲的是, 在创建UITabBarController的UITabBar标签栏的时候, 容易困扰也容易被大家忽视的UITabBarButton的问题. 

### 1.什么是UITabBarButton? 
#### &1.
我们都知道UITabBarController下方的工具条称为UITabBar ，如果UITabBarController有N个子控制器,那么UITabBar内部就会有N 个UITabBarButton作为子控件与之对应。

####也就是说,UITabBarButton是UITabBarController中各个子控制器在工具条中对应的按钮的称呼, 

同时我们可以注意到一个现象,那就是我们创建好UITabBarButton之后,各个UITabBarButton在UITabBar中的位置是均分的，UITabBar的高度为49。
如:    我这里有一个创建好的UITabBarController
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建4个子控制器
    [self setupChildViewController];
}

#pragma mark - 创建TabBarController的4个子控制器
// 封装创建TabBarController的4个子控制器的方法
- (void)setupChildViewController {
    
    // 添加四个TabBarController的子控制器UINavigationController
    // 首页Home
    UINavigationController *navHome = [self navigationControllerWithStoryboardName:@"DXHome"];
    [self setupOneChildViewController:navHome image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    // 消息message
    UINavigationController *navMessage = [self navigationControllerWithStoryboardName:@"DXMessage"];
    [self setupOneChildViewController:navMessage image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];

    // 发现discover
    UINavigationController *navDiscover = [self navigationControllerWithStoryboardName:@"DXDiscover"];
    [self setupOneChildViewController:navDiscover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];

    // 我profile
    UINavigationController *navProfile = [self navigationControllerWithStoryboardName:@"DXProfile"];
    [self setupOneChildViewController:navProfile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    
    // 添加到tabBar
    self.viewControllers = @[navHome, navMessage, navDiscover, navProfile];

}

#pragma mark - 创建一个子控制器的方法
// 封装创建一个子控制器的方法
- (void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
  
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"10";
    vc.tabBarItem.title = title;
}

#pragma mark - 封装通过storyboard创建NavigationController的方法
// 封装通过storyboard创建NavigationController的方法
- (UINavigationController *)navigationControllerWithStoryboardName:(NSString *)name {
    // 1. 加载storyboard文件
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    // 2. 创建Storyboard中的初始化控制器
    return [storyboard instantiateInitialViewController];
}


```

运行出来之后,效果是这样的:

![效果图](https://static.oschina.net/uploads/img/201602/19154036_Lu1a.png "在这里输入图片标题")
 
通过这个实例,可以看出,在上面的程序中，UITabBarController有4个子控制器,所以UITabBar中有4个UITabBarButton，UITabBar的结构⼤大致如下图所示：

![UITabBar结构](https://static.oschina.net/uploads/img/201602/19154616_NPfk.png "在这里输入图片标题")

#### &2  UITabBarButton⾥面显⽰什么内容,由对应子控制器的tabBarItem属性来决定 

 代码:
```
// 封装创建一个子控制器的方法
- (void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
  
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"10";
    vc.tabBarItem.title = title;
    
}


  // 首页Home
    UINavigationController *navHome = [self navigationControllerWithStoryboardName:@"DXHome"];
    [self setupOneChildViewController:navHome image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];


```
具体表现为:  如图
![UITabBarButton的显示的是tabBarItem属性内容](https://static.oschina.net/uploads/img/201602/19160807_IOh9.png "在这里输入图片标题")


### 2. 如何自定义UITabBarButton  
#### 那么首先. 如何查看UITabBarButton,也就是如何找到UITabBarButton?

首先我们需要明确的是UITabBarButton是私有属性private的,  怎样验证它是私有属性呢?   大家可以测试一下, 当我们在代码中想输入
UITabBarButton的时候,是没有提示的,而且到苹果官方提供的框架中,和帮助文档中, 都是找不到UITabBarButton的, 

![代码输入结果](https://static.oschina.net/uploads/img/201602/19161643_AdYG.png "在这里输入图片标题")

![帮助文档查询结果](https://static.oschina.net/uploads/img/201602/19161658_ArUg.png "在这里输入图片标题")

那么问题来了?  我们如何能看见UITabBarButton呢?  或者说UITabBarButton是不是不存在呢? 
这里我可以告诉大家的是, UITabBarButton肯定存在!!

接下来我就把调出UITabBarButton的方法告诉大家: 
看代码: 
```
 在继承自UITabBarController的类中

// 系统view控件准备好之后调用这个方法
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 打印查看tabBar的所有子控件
     NSLog(@"----%@", self.tabBar.subviews);
}
```
输出结果为:
![输出结果](https://static.oschina.net/uploads/img/201602/19162652_WQ3i.png "在这里输入图片标题")
**通过结果可以看出: **
** 通过打印self.tabBar.subviews的所有子控件的方法,就可以输出查看UITabBarButton;**
可以明显的看出, 这个案例里面的tabBar是由6个子控件的,其中有4个UITabBarButton控件,

### 3. 知道了UITabBarButton,那我们能做什么?
一旦我们知道了UITabBarButton在哪里,是什么, 那么我们就可以做很多事情了, 如: 
##### &1.  可以直观的实时的检测UITabBarButton的情况,实时监控tabBar的状态;
##### &2. 我们可以在不全部推倒tabBar重来的情况下,自定义UITabBarButton的位置, 
##### &3 ......  当然还有其他的功能,由于时间关系,我这里就不在赘述了, 大家可以自己去尝试....
**通常来说,我们主要是使用第2点,  比如, 新浪微博的tabBar,就是这样使用的, 在不改变tabBar本身,不使用图片代替tabBarItem的情况下, 添加一个自定义的按钮到tabBar工具条中, 同时,调整按钮的位置,**

### 4 效果演示:
我们先来看看,新浪微博的tabBar工具条的效果图:

新浪微博首页效果
![新浪微博首页效果](https://static.oschina.net/uploads/img/201602/19164200_k8hF.png "在这里输入图片标题")


tabBar工具条的效果图:
![tabBar工具条的效果图:](https://static.oschina.net/uploads/img/201602/19164236_xO7e.png "在这里输入图片标题")

那这样的效果, 需要怎样来实现?

很简单, 但是,又有不少值得注意的地方: 

##### 直接上代码: 
  
先创建一个自定义的TabBar类:

```
//  DXTabBar.h
//  DXSWeibo
//  Created by xiongdexi on 16/2/19.
//  Copyright © 2016年 DXSmile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXTabBar : UITabBar

@end
```
```
//  DXTabBar.m
//  DXSWeibo
//  Created by xiongdexi on 16/2/19.
//  Copyright © 2016年 DXSmile. All rights reserved.
//

#import "DXTabBar.h"

@implementation DXTabBar
@end
```
返回DXTabBarController中, 创建自定义的tabBar
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建4个子控制器
    [self setupChildViewController];

    // 自定义tabBar
    // 1. 先创建一个自定义tabBar
    DXTabBar *tabBar = [[DXTabBar alloc] initWithFrame:self.tabBar.frame];
    
    NSLog(@"%@", self.tabBar);

    // 2. 利用KVC把readonly权限改过来
    [self setValue:tabBar forKeyPath:@"tabBar"];
    NSLog(@"%@", self.tabBar);
    
}
```
注意点: 如下
```
// tabBar的底层 权限是readonly(只读)
@property(nonatomic,readonly) UITabBar *tabBar NS_AVAILABLE_IOS(3_0); // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.
 /**
     *  分析: tabBar底层是只读的readonly权限,那我们要自定义tabBar,如何来修改这个权限呢?
     *
     *  @return 可以用KVC的方法
     */
// 2. 利用KVC把readonly权限改过来
    [self setValue:tabBar forKeyPath:@"tabBar"];
```

上面的测试输出为: 

![自定义tabBar](http://upload-images.jianshu.io/upload_images/1483059-2db4cd5cc7b484ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


通过,输出结果,可以看出, 我们已经成功的更改了tabBar的权限,改为了,我们自定义的tabBar, 那么此时我们需要来验证一下,是否还可以拿到UITabBarButton; 

同样调用之前的方法: 这里我们在另一个方法中来测试,
```
// 系统在即将开始为view准备控件的时候调用这个方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", self.tabBar.subviews);
}
```
输出结果为:
![自定义之后重新验证UITabBarButton](http://upload-images.jianshu.io/upload_images/1483059-2b7f15d74fa38c3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

那么接下来,我们就可以开始写代码了:
 ```
//  DXTabBar.m
//  DXSWeibo
//  Created by xiongdexi on 16/2/19.
//  Copyright © 2016年 DXSmile. All rights reserved.
//

#import "DXTabBar.h"
@interface DXTabBar ()
// 定义中间按钮的属性
@property (nonatomic, weak) UIButton *plusButton;
@end

@implementation DXTabBar
#pragma mark - 懒加载设置中间按钮 保证只有一个
- (UIButton *)plusButton {
    if (_plusButton == nil) {
        // 1.根据自定义类型初始化一个button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 2.设置btn的各状态的图片属性
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 3. 设置btn按钮的尺寸和图片的默认大小一样大
        [btn sizeToFit];
        
        // 4. 把按钮赋值给_plusButton
        _plusButton = btn;
        
        // 5. 把按钮添加到tabBar中 ,建立强引用
        [self addSubview:_plusButton];
    } 
    return _plusButton;
}

#pragma mark - 调整子控件的位置和尺寸
// 调整子控件的位置和尺寸
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat butX = 0;  // x 是不确定的,可以初始化为0
    CGFloat butY = 0;  // y 就是0
    CGFloat butW = w / (self.items.count + 1); // 有几个UITabBarButton就有几个items模型
    CGFloat butH = h;
    
    int i = 0; // 定义角标,初始化为0
    // 调整系统自带的tabBar上面的按钮的位置
    for (UIView *tabBarButton in self.subviews) {
        // 判断是否是UITabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 因为中间需要预留一个位置,所以,当i到中间的是,就跳过
            if (i == 2) {
                i = 3;
            }
            butX = i * butW;  
            tabBarButton.frame = CGRectMake(butX, butY, butW, butH);
            i++;
        }
    }

    // 设置中间按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}
```
效果图: 

![中间按钮效果图](http://upload-images.jianshu.io/upload_images/1483059-550502e731be99c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

//
//  DXTabBarController.m
//  DXSWeibo
//
//  Created by xiongdexi on 16/2/18.
//  Copyright © 2016年 DXSmile. All rights reserved.
//

#import "DXTabBarController.h"
#import "UIImage+DXImage.h"
#import "DXTabBar.h"
#import <objc/message.h>


@interface DXTabBarController ()



@end

@implementation DXTabBarController


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建4个子控制器
    [self setupChildViewController];
    
    // 自定义tabBar
    /**
     *  分析: tabBar底层是只读的readonly权限,那我们要自定义tabBar,如何来修改这个权限呢?
     *
     *  @return 可以用KVC的方法
     */
    // 1. 先创建一个自定义tabBar
    DXTabBar *tabBar = [[DXTabBar alloc] initWithFrame:self.tabBar.frame];
    
    NSLog(@"%@", self.tabBar);

    
    // 2. 利用KVC把readonly权限改过来
    [self setValue:tabBar forKeyPath:@"tabBar"];
    NSLog(@"%@", self.tabBar);
    
}
// 系统在即将开始为view准备控件的时候调用这个方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", self.tabBar.subviews);
}
//// 系统为view控件准备接受之后调用这个方法
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    // 打印查看tabBar的所有子控件
//     NSLog(@"----%@", self.tabBar.subviews);
//}

#pragma mark - 统一设置tabBarItem的外观标识
// 当第一次使用这个类,或子类的时候调用,用于来初始化类
// 用这个方法,来设置全局的tabBarItem的外观
+ (void)initialize {
    
    // 获取所有的tabBarItem外观标识
    //    UITabBarItem *item = [UITabBarItem appearance];
    /**
     *  但是这里如果用appearance来设置,是不严谨的,因为,所有的UIView控件都是有这个属性的,所以,应该用自己的,如下: appearanceWhenContainedIn:这个方法里面的self 表示的就是当前类DXTabBarController;
     */
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    //    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];   下面的写法更加好看,也看起来舒服
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DXTabBar.m
//  DXSWeibo
//
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
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
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
//    NSLog(@"%@", self.subviews); // 调试测试TabBarItem的子控件, 可以看出,里面包含UITabBarButton
    
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
        // 注意:因为UITabBarButton是私有的API,所以,不能直接比较,这里用的是反射机制,根据一个字符串反射出类; UITabBarButton需要输出
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 因为中间需要预留一个位置,所以,当i到中间的是,就跳过
            if (i == 2) {
                i = 3;
            }
            
//            NSLog(@"%@", tabBarButton); // 测试验证是否有了UITabBarButton
            // 通过测试可以看出,已经有了UITabBarButton,那么接下来就是计算UITabBarButton的frame就可以了
            butX = i * butW;
            
            tabBarButton.frame = CGRectMake(butX, butY, butW, butH);
            
            i++;
        }
        
    }
   
    
    // 设置中间按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

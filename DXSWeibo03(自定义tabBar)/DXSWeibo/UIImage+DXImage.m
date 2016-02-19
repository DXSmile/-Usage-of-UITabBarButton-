//
//  UIImage+DXImage.m
//  DXSWeibo
//
//  Created by xiongdexi on 16/2/18.
//  Copyright © 2016年 DXSmile. All rights reserved.
//

#import "UIImage+DXImage.h"

// 返回原始图片的分类
@implementation UIImage (DXImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName {

    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end

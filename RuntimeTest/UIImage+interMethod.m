//
//  UIImage+interMethod.m
//  RuntimeTest
//
//  Created by YeYiFeng on 2018/3/30.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "UIImage+interMethod.h"
#import <objc/runtime.h>
@implementation UIImage (interMethod)
// 新添加方法
+(UIImage*)yz_imageNamed:(NSString*)name
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage yz_imageNamed:name];
}
// 重写UIImage的load方法
+(void)load
{
    // 获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(yz_imageNamed:));
    // 开始交换方法实现
    method_exchangeImplementations(m1, m2);

}
@end

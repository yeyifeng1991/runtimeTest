//
//  UIViewController+HandleMethod.m
//  ImageTest
//
//  Created by YeYiFeng on 2018/4/3.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "UIViewController+HandleMethod.h"
#import <objc/runtime.h>
@implementation UIViewController (HandleMethod)
// load方法会在类加载的时候调用
+(void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
       // 拿到方法的SEL名称
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(mrc_viewWillAppear:);
        // 通过类拿到方法
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        // 如果发现方法已经存在，会失败返回
        // 方法不存在，尝试添加替换
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            // 方法不存在 主类本身没有实现需要替换的方法，而是继承了父类的实现
//            class_replaceMethod这个方法. class_replaceMethod本身会尝试调用class_addMethod和method_setImplementation，所以直接调用class_replaceMethod就可以了)
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            NSLog(@"方法不存在");
            
        } else {
            NSLog(@"方法存在");
            // 方法存在直接替换
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}
- (void)mrc_viewWillAppear:(BOOL)animated {
    [self mrc_viewWillAppear:animated];
    // 执行相关操作
    NSLog(@"执行viewWillAppear的相关操作 ====");
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

@end

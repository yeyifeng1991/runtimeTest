//
//  ViewController.m
//  RuntimeTest
//
//  Created by YeYiFeng on 2018/3/30.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "person1.h"
@interface ViewController ()

@end
/*
 runtime可以实现的功能
 1.动态的交换两个方法的实现
 2.动态的添加对象的成员变量和成员方法
 3.获得某个类的所有成员方法、所有成员变量
 
 使用场景：
 1.将oc代码转换为运行时代码，研究底层
 进入到包含main.m上层文件
 clang -rewrite-objc main.m
 编译  已经演示过
 2.拦截系统自带的方法调用,imageNamed,ViewDidLoad，alloc
 3.实现分类和增加属性
 4.实现NSCoding的自动归档和接档  已经实现
 5.实现字典和模型的相互转换
 
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self exchangeMethod];
    
}
/*
 Method class_getClassMethod(Class cls , SEL name) 类方法
 Method class_getInstanceMethod(Class cls , SEL name) 对象方法

 */
#pragma mark  - 交换方法
-(void)exchangeMethod
{
    // 1.交换之前
   
    /*
     [person1 run];
     [person1 study];
     执行结果：
     2018-03-30 17:57:59.431771+0800 RuntimeTest[6742:531544] 奔跑吧兄弟
     2018-03-30 17:57:59.431900+0800 RuntimeTest[6742:531544] 代码干起来，学习起来
     */
    //2. 交换之后
    // 1.获取类的方法
    Method  m1 = class_getClassMethod([person1 class], @selector(run));
     Method  m2 = class_getClassMethod([person1 class], @selector(study));
    // 2.开始交换
    method_exchangeImplementations(m1, m2);
    // 3.方法调用
    [person1 run];
    [person1 study];
    /*
     打印结果
     2018-03-30 18:37:59.568932+0800 RuntimeTest[7132:554880] 代码干起来，学习起来
     2018-03-30 18:37:59.569086+0800 RuntimeTest[7132:554880] 奔跑吧兄弟
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

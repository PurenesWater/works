

//
//  Person+Man.m
//  wxd
//
//  Created by administrator on 2017/7/5.
//  Copyright © 2017年 XD. All rights reserved.

//
// 类目
// 在类目中 ，只能添加方法，不能添加属性 ，如果想添加属性，必须写get和set 方法
// 用运行时机制

#import "Person+Man.h"
#import <objc/runtime.h>

@implementation Person (Man)

-(void)initSetName {
    
    NSLog(@"你好啊 ，runTime");
}

/**
 *  根据某个对象，还有key，还有对应的策略(copy,strong等) 动态的将值设置到这个对象的key上
 *
 *  @param object 某个对象
 *  @param key    属性名,根据key去获取关联的对象
 *  @param value  要设置的值
 *  @param policy 策略(copy,strong，assign等)
 */
-(void)setTitle:(NSString *)title {
    
    objc_setAssociatedObject(self, @"title", title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 *  根据某个对象，还有key 动态的获取到这个对象的key对应的属性的值
 *
 *  @param object 某个对象
 *  @param key    key
 *
 *  @return 对象的值
 */
-(NSString *)title {
    
    return objc_getAssociatedObject(self, @"title");
}


+(void)load {

    //获取类对象的方法
    Method  old = class_getInstanceMethod([Person class],@selector(sub));
    
    Method  new = class_getInstanceMethod([Person class], @selector(subStr));
    
    //交换方法实现
    method_exchangeImplementations(old, new);
}

-(void)subStr {
    
    NSLog(@"我是新的");
}



@end

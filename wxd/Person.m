

//
//  Person.m
//  wxd
//
//  Created by administrator on 2017/7/4.
//  Copyright © 2017年 XD. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person  ()

/**
 *
 */
@property (nonatomic ,strong) NSString  *count;

/**
 *
 */
@property (nonatomic ,assign) int age;


/**
 *
 */
@property (nonatomic ,assign) NSInteger teg;

//私有方法
+(void)areYouCenter;

@end

@implementation Person

@synthesize sexssss = _sexssss;


-(int)age {
    
    return _age = 24;
}

-(void)setSexssss:(NSString *)sexssss {
    
    _sexssss = sexssss;
}

-(NSString *)sexssss {
    
    return _sexssss = @"woshi";
}

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        _count = @"21";
    
    }
    return self;
}

-(void)sub {
    
  NSLog(@"我是原装");
}

////动态添加
//+(BOOL)resolveInstanceMethod:(SEL)sel {
//    
//    if (sel == @selector(eat:)) {
//        
//        BOOL isSuc =  class_addMethod(sel, sel, (IMP)eat:, @"");
//        
//        return isSuc;
//    }
//
//    return YES;
//}

-(void)cat {
    
}

@end

//
//  Person.h
//  wxd
//
//  Created by administrator on 2017/7/4.
//  Copyright © 2017年 XD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@interface Person : NSObject

/**
 *
 */
@property (nonatomic ,strong) NSString  * name;


/**
 *
 */
@property (nonatomic ,strong) NSString  * sexssss;
/**
 *
 */
@property (nonatomic ,assign) int  ages;


/**
 *
 */
//@property (nonatomic ,copy) void(^pushControl)(UIViewController *viewControl);


-(void)sub;


-(void)cat;



@end

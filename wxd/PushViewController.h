//
//  PushViewController.h
//  wxd
//
//  Created by administrator on 2017/7/5.
//  Copyright © 2017年 XD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^seconControl)(NSString * text);


@interface PushViewController : UIViewController

/**
 *
 */
@property (nonatomic ,copy) seconControl cont;


@end

//
//  PushViewController.m
//  wxd
//
//  Created by administrator on 2017/7/5.
//  Copyright © 2017年 XD. All rights reserved.
//

#import "PushViewController.h"
#import "ViewController.h"

@interface PushViewController ()

@property (strong, nonatomic) IBOutlet UITextField *result;

/**
 *
 */
@property (nonatomic ,strong) NSMutableArray  * arr;

@end

@implementation PushViewController


- (IBAction)point:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
       
        self.cont(self.result.text);

    }];
}


@end

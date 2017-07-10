//
//  ViewController.m
//  wxd
//
//  Created by administrator on 2017/7/4.
//  Copyright © 2017年 XD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "PushViewController.h"
#import "Person+Man.h"


typedef struct {

    int age ;
    char *mame;

}Man;

@interface ViewController ()<UITextFieldDelegate>

/**
 *
 */
@property (nonatomic ,strong) NSString  * name;



@property (strong, nonatomic) IBOutlet UITextField *pushText;

@end

@implementation ViewController
{
    Person * person;
    UITextField * texy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    CGSize  size = CGSizeMake(100, 100);
    //将集合转换成对象
    NSValue * value = [NSValue  valueWithCGSize:size];
    
    NSArray  * arr =   @[value];
    
    NSLog(@"%@",arr);
    
//    [self setPerson];
//    __block int x = 5; //可以修改block 里的常量
//         int x = 5;   //不可以修改里边的常量
//    int (^block4)(int) = ^(int y) {
//        
//        NSLog(@" x = %d",x);
//        int z = x+y;
//        return z;
//    };
//    NSLog(@"%d,%d",x +=5,block4(5));
    

}


#pragma mark Block 

-(void)timerAction {
    
    NSLog(@"%d",__LINE__);
}

#pragma mark runtime 运用
-(void)setPerson {
    
    Person * per = [[Person alloc] init];
    
    per.sexssss = @"nishi";
    //    NSLog(@"%@",[per description]);
    
    per.name = @"你好";
    
    per.title = @"不好";
    
    NSLog(@"nameSex = %@",per.title);
    
    [per initSetName];
    
    [per cat];
    
    //获取成员变量
    unsigned int count = 0;
    
    Ivar *iva = class_copyIvarList([Person class], &count);
    
    for (int i  = 0; i <count; i++) {
        
        Ivar ier = iva[i];
        
        const char * mes =  ivar_getName(ier);
        
        NSString * str  = @(mes);
        
        const char * mes1 =  ivar_getTypeEncoding(ier);
        
        NSString * type  = @(mes1);
        
        NSLog(@"str ==%@ , type == %@",str ,type);
    }
    
    //修改私变量的修改
    Ivar mea = iva[3];
    object_setIvar(per, mea, @"123");
    NSLog(@"second time : %@",[per description]);
    
    
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    for (unsigned int i=0; i<count; i++) {
        
        const char *propertyName = property_getName(propertyList[i]);
        
        const char *value = property_getAttributes(propertyList[i]);
        
        NSLog(@"property---->%@ %@", [NSString stringWithUTF8String:propertyName] ,@(value));
    }
    
    
    UIButton * bu  = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    [bu setTitle:@"点击" forState:(UIControlStateNormal)];
    [bu addTarget:self action:@selector(point) forControlEvents:(UIControlEventTouchUpInside)];
    bu.backgroundColor = [UIColor redColor];
    [self.view addSubview:bu];

}

//按钮点击
-(void)point {
    
//    PushViewController * pu = [[PushViewController alloc] init];
//    
//    [self presentViewController:pu animated:YES completion:nil];
    
}

-(void)dealloc {
    
    NSLog(@"%s",__func__);
}


#pragma mark Block 传值
- (IBAction)point:(UIButton *)sender {
    
    // xxxxx :可以将参数拼接在url后边，这样在另一个APP的openUrl方法中，解析这个url中的参数就可以了
    NSString * UrlStr = @"SecondApp://xxxxx";
    
    NSURL * url = [NSURL URLWithString:UrlStr];
    
    // 在这里可以先做个判断
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
        
    }else{
        
        
    
    }
    
    
    /*
     
    PushViewController * pu = [[UIStoryboard  storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"push"];

     //防止循环引用
     __weak typeof(*&self) weakSelf = self;
    
     //在block里 ，修改局部变量 ，必须用__block 修饰
     __block int a = 0 ;
     //后边往前边传值
     pu.cont = ^(NSString *text) {
         
        a = 3;
         
       weakSelf.pushText.text = text;
         
        NSLog(@"%d",a);
     };
    [self presentViewController:pu animated:YES completion:nil];
     
    */
     
}
// 设置 textFile
-(void)setRightViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName{
    
    UIImageView *rightView = [[UIImageView alloc]init];
    rightView.image = [UIImage imageNamed:imageName];
    [rightView  sizeToFit];
    rightView.contentMode = UIViewContentModeCenter;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

//  KVO
-(void)studyKVO {
    
    texy = [[UITextField alloc] initWithFrame:CGRectMake(80, 100, 200, 33)];
    texy.placeholder = @"你好";
    texy.borderStyle = UITextBorderStyleRoundedRect;
    texy.delegate = self;
    [self setRightViewWithTextField:texy imageName:@"人.png"];
    [self.view addSubview:texy];
    
    //KVO 键值观察者
    person = [[Person alloc] init];
    
    //对象调用
    //forKeyPath ： 对象的属性
    [texy addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason  {
    
    person.name = textField.text;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    id oldName = [change objectForKey:NSKeyValueChangeOldKey];
    id newName = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"old = %@ , new = %@", oldName , newName) ;
    //移除监听
    [texy removeObserver:self forKeyPath:@"text"];
}

//字典转模型
-(void)setKVC {
    
    //KVC 模型转字典
    person = [[Person alloc] init];
    person.ages = 20 ;
    [person setValue:@"liSan" forKey:@"name"];
    //   [person setValue:@"男" forKey:@"sexssss"];
    NSDictionary * dic = [person dictionaryWithValuesForKeys:@[@"ages" ,@"name",@"sexssss"]];
    
    //获取私有属性和属性
    NSString * age = [person valueForKey:@"age"];
    NSString * sexs = [person valueForKey:@"sexssss"];
}

// RunLoop
-(void)setRundLoop {
    /*
    NSDefaultRunLoopMode,
    NSEventTrackingRunLoopMode,
    UIInitializationRunLoopMode,
    NSRunLoopCommonModes,
    NSConnectionReplyMode,
    NSModalPanelRunLoopMode
    */
    
    
}



@end

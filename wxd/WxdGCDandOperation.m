
//
//  WxdGCDandOperation.m
//  wxd
//
//  Created by administrator on 2017/7/6.
//  Copyright © 2017年 XD. All rights reserved.
//

#import "WxdGCDandOperation.h"

@implementation WxdGCDandOperation
{

//   [self queueAsyncExcute];
//   [self queueSyncExcute];
//   [self queueSeralSync];
//   [self queueSeralAsync];
//   [self queueMainSync];
//   [self queueMainAsync];
//   [self queueGroup];

//    [self creatSlineOperation];
//    [self queueOperationQueue];
//    [self queueOperationSelarAndCoun];

//  [self queueOperationRely];

}

#pragma mark Operation  依赖
-(void)queueOperationRely {
    
    NSOperationQueue * otherQ = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *bloc =[NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *bloc1 =[NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    }];
    
    //依赖 bloc 依赖bloc1 ,bloc1先执行
    [bloc addDependency:bloc1];
    
    [otherQ addOperation:bloc];
    [otherQ addOperation:bloc1];
    
}


#pragma mark NSOperation 串行和并发
-(void)queueOperationSelarAndCoun {
    
    //异步 + 并发 ，开启多个子线程 ，任务交替执行
    NSOperationQueue * other = [[NSOperationQueue alloc] init];
    
    //串行 + 异步，只开启一条线程 ，任务按顺序执行
    //默认 maxConcurrentOperationCount为-1 ，并发 ，所以设置1 ，为串行
    other.maxConcurrentOperationCount = 1;
    
    [other addOperationWithBlock:^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    [other addOperationWithBlock:^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    }];
    [other addOperationWithBlock:^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    }];
    [other addOperationWithBlock:^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    }];
}



#pragma mark NSOperationQueue 其他队列
-(void)queueOperationQueue {
    
    //开启多条新的子线程 ，任务交替执行 。 并发 异步执行
    NSOperationQueue * otherQueue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation * inval = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    NSBlockOperation * nlock =[NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
        
    }];
    [otherQueue addOperation:inval];
    [otherQueue addOperation:nlock];
    
    
    
    //开启多条新的子线程 ，任务交替执行 。 并发 异步执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"-----%@", [NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    }];
}

#pragma mark NSOperation 队列
-(void)queueOperation {
    
    //NSOperationQueue一共有两种队列：主队列、其他队列
    //主队列
    NSOperationQueue * mainQueue = [NSOperationQueue mainQueue] ;
    //其他队列： 串行 ，并发
    NSOperationQueue *otherQueue = [[NSOperationQueue alloc] init];
}


#pragma mark NSOperation 子类
-(void)creatSlineOperation {
    
    //没有开启新的线程
    //    NSInvocationOperation * oper = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //    [oper start];
    
    NSBlockOperation  *bloc = [NSBlockOperation blockOperationWithBlock:^{
        //主线程
        NSLog(@"Thread -- %@",[NSThread currentThread]);
    }];
    
    //子线程
    [bloc addExecutionBlock:^{
        
        NSLog(@"Thread -- %@",[NSThread currentThread]);
        
    }];
    
    [bloc start];
}

-(void)run {
    
    for (int i = 0; i < 5; ++i) {
        NSLog(@"2------%@",[NSThread currentThread]);
    }
    
}


#pragma mark 队列组
-(void)queueGroup {
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        
        NSLog(@"1");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        NSLog(@"3");
    });
    
    
}


#pragma mark 主线程 + 同步
-(void)queueMainSync {
    
    dispatch_queue_t que = dispatch_get_main_queue();
    
    NSLog(@"star");
    
    dispatch_sync(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"11------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(que, ^{
        
        
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"11------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"11------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"end");
    
}


#pragma mark 主线程 + 异步
-(void)queueMainAsync {
    
    
    //主队列 + 异步：不开启新线程，所有任务在主线程， 一个完成，另一个开始
    
    dispatch_queue_t que = dispatch_get_main_queue();
    
    NSLog(@"star");
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"11------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"12------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"13------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"end");
}


#pragma mark  串行 + 异步
-(void)queueSeralAsync {
    
    //串行+异步 ：串行队列 ，吧所有的任务添加到队列中 ，才开始执行
    // 开启一条新的线程 ，按顺序执行
    
    dispatch_queue_t que = dispatch_queue_create("yelleo.queue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"1222");
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"11------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"12------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 5; ++i) {
            NSLog(@"13------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"22211");
}


#pragma mark 串行 + 同步
-(void)queueSeralSync {
    
    //串行+同步：没有开启子线程，都在主线程中完成； 一个线程执行完 ，另一个才会执行
    //串行队列
    dispatch_queue_t  que  = dispatch_queue_create("te.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(que, ^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"7------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(que, ^{
        
        for (int i = 0; i < 100; ++i) {
            NSLog(@"8------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(que, ^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"9------%@",[NSThread currentThread]);
        }
    });
    
}

#pragma mark 并发 + 异步
-(void)queueAsyncExcute {
    
    //并发+异步 ，同时开启多条子线程 ，任务交替执行
    //并发队列
    dispatch_queue_t que = dispatch_queue_create("name.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(que, ^{
        
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
}

#pragma mark 同步并发队列
-(void)queueSyncExcute {
    
    //同步 + 并发 ： 没有开辟子线程，在主线程内，一个执行完 ，另一个才会执行
    //并发队列
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    //同步
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    });
    
    
    [NSThread sleepForTimeInterval:2];
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 100; ++i) {
            NSLog(@"5------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            
            NSLog(@"6------%@",[NSThread currentThread]);
        }
    });
}









@end

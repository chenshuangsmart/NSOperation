//
//  ViewController.m
//  NSOperation
//
//  Created by cs on 2018/6/23.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "ViewController.h"
#import "CSOperation.h"

@interface ViewController ()

@end

@implementation ViewController{
    int _ticketSurplusCount;
    NSLock *_lock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self useInvocationOperation];
//    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];
    
//    [self useBlockOperation];
//    [self useBlockOperationAddExecutionBlock];
    
//    [self useCustomOperation];
//    [self addOperationToQueue];
//    [self addOperationWithBlockToQueue];
//    [self addMaxConcurrentOperationCount];
//    [self addDependency];
//    [self communication];
//    [self initTicketStatusNotSave];
    [self initTicketStatusSave];
}

/**
 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {
    // 1.创建NSInvocationOperation对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    // 2.开始执行操作
    [op start];
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
    }
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
    }
}

/**
 使用子类NSBlockOperation:
 */
- (void)useBlockOperation {
    // 创建 NSBlockOperation 对象
    NSBlockOperation  *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 开始执行操作
    [op start];
}

/**
 使用子类 NSBlockOperation调用AddExecutionBlock方法
 */
- (void)useBlockOperationAddExecutionBlock {
    // 创建 NSBlockOperation 对象
    NSBlockOperation  *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"7---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 开始执行操作
    [op start];
}

/**
 使用自定义继承自 NSOperation 的子类
 */
- (void)useCustomOperation {
    CSOperation *op = [[CSOperation alloc] init];
    [op start];
}

/**
 将操作添加到操作队列中
 */
- (void)addOperationToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

/**
 使用 addOperationWithBlock: 将操作加入到操作队列中
 */
- (void)addOperationWithBlockToQueue {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 使用 addOperationWithBlock添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 设置 MaxConcurrentOperationCount（最大并发操作数）
 */
- (void)addMaxConcurrentOperationCount {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置对的并发数
//    queue.maxConcurrentOperationCount = 1;  // 串行队列
//    queue.maxConcurrentOperationCount = 2;  // 并行队列
    queue.maxConcurrentOperationCount = 9;  // 并行队列
    
    // 使用 addOperationWithBlock添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 添加操作依赖
 */
- (void)addDependency {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 添加依赖
    [op2 addDependency:op1];    // 让 op2依赖于 op1.则先执行 op1，再执行 op2
    
    // 添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

/**
 线程间通信
 */
- (void)communication {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 添加操作
    [queue addOperationWithBlock:^{
        // 异步执行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%d---%@",i, [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

/**
 * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
 * 非线程安全：不加速-NSLock
 */
- (void)initTicketStatusNotSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]); // 打印当前线程

    _ticketSurplusCount = 50;
    
    // 1.创建 queue1,queue1 代表广州火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    // 2.创建 queue2,queue2 代表龙岩火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
  
    // 3.创建卖票操作 op1
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketNotSafe];
    }];
    
    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketNotSafe];
    }];
    
    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 售卖火车票
 */
- (void)saleTicketNotSafe {
    while (1) {
        if (_ticketSurplusCount > 0) {
            // 如果还有票，就接着卖)
            _ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%d 窗口:%@", _ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

/**
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 * 线程安全：加锁-NSLock
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]); // 打印当前线程
    
    _ticketSurplusCount = 50;
    _lock = [[NSLock alloc] init];
    
    // 1.创建 queue1,queue1 代表广州火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    // 2.创建 queue2,queue2 代表龙岩火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    // 3.创建卖票操作 op1
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 售卖火车票
 */
- (void)saleTicketSafe {
    while (1) {
        [_lock lock];
        if (_ticketSurplusCount > 0) {
            // 如果还有票，就接着卖)
            _ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%d 窗口:%@", _ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }
        [_lock unlock];
        
        if (_ticketSurplusCount <= 0) {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

@end

//
//  RunLoopViewController.m
//  swift-study
//
//  Created by 永平 on 2021/4/26.
//  Copyright © 2021 永平. All rights reserved.
//

#import "RunLoopViewController.h"
#import <objc/runtime.h>

@interface RunLoopViewController () {
    CFRunLoopObserverRef runLoopObserver;
    NSTimer *timer;
}
@property(nonatomic, strong) dispatch_source_t gcd_timer;
@end

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
   
//    switch (activity) {
//        case kCFRunLoopEntry:
//            NSLog(@"----kCFRunLoopEntry");
//        case kCFRunLoopBeforeTimers:
//            NSLog(@"----kCFRunLoopBeforeTimers");
//        case kCFRunLoopBeforeSources:
//            NSLog(@"----kCFRunLoopBeforeSources");
//        case kCFRunLoopBeforeWaiting:
//            NSLog(@"----kCFRunLoopBeforeWaiting");
//        case kCFRunLoopAfterWaiting:
//            NSLog(@"----kCFRunLoopAfterWaiting");
//        case kCFRunLoopExit:
//            NSLog(@"----kCFRunLoopExit");
//        default:
//            break;
//    }
}

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    
    [self startMonitor];
    
    // touchesBegan
    // 按钮点击
    // Perform
    // 手势
    // NSTimer
    // GCD Timer main queue
    // GCD Timer global queue
    // dispatch_after global queue
    // dispatch_after main queue
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [self.view addGestureRecognizer:gesture];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
//    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = UIColor.redColor;
//    [self.view addSubview:button];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//        [self tap];
//    });
    
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"");
//    }];
    
//    self.gcd_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    // MARK: 2.设置Timer的执行间隔时间、第一次执行的延时时间.
//        dispatch_source_set_timer(self.gcd_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
//        /// MARK: 3.Timer执行的方法
//        dispatch_source_set_event_handler(self.gcd_timer, ^{
//            NSLog(@"gcd_timergcd_timer");
//        });
//        // 另:可以传参的dispatch_source_set_event_handler
//        //    dispatch_source_set_event_handler_f(<#dispatch_source_t  _Nonnull source#>, <#dispatch_function_t  _Nullable handler#>)
//        /// 执行Timer
//
//        /// MARK: 3.开启Timer.注:这个不能多次调用.建议用一个属性值记录Timer的执行状态.多次调用会崩溃.
//        dispatch_resume(self.gcd_timer);

        /// MARK: 4.挂起Timer(挂起状态不能置为nil).只能在dispatch_resume后cancel.并且dispatch_resume和dispatch_suspend一一对应.重复调用dispatch_suspend会崩溃.
//        dispatch_suspend(self.gcd_timer);
}

- (void)tap {
    NSLog(@"tap");
}

- (void)startMonitor {
    //创建一个观察者
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                 kCFRunLoopAllActivities,
                                                 YES,
                                                 0,
                                                 &runLoopObserverCallBack,
                                                 &context);
    //将观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----touchesBegan");
}
//
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----touchesEnded");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----touchesCancelled");
}

@end


//
// touchesBegan
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
//  * frame #0: 0x0000000100081ea4 swift-study`-[RunLoopViewController touchesBegan:withEvent:](self=0x0000000106311980, _cmd="touchesBegan:withEvent:", touches=1 element, event=0x0000000282bac3c0) at RunLoopViewController.m:60:5
//    frame #1: 0x000000018d43e924 UIKitCore`forwardTouchMethod + 344
//    frame #2: 0x000000018d43e7a8 UIKitCore`-[UIResponder touchesBegan:withEvent:] + 64
//    frame #3: 0x000000018d44d3f0 UIKitCore`-[UIWindow _sendTouchesForEvent:] + 496
//    frame #4: 0x000000018d44ef44 UIKitCore`-[UIWindow sendEvent:] + 3976
//    frame #5: 0x000000018d4282cc UIKitCore`-[UIApplication sendEvent:] + 712
//    frame #6: 0x000000018d4b21ec UIKitCore`__dispatchPreprocessedEventFromEventQueue + 7360
//    frame #7: 0x000000018d4b51a4 UIKitCore`__processEventQueue + 6460
//    frame #8: 0x000000018d4ac650 UIKitCore`__eventFetcherSourceCallback + 160
//    frame #9: 0x000000018a9d076c CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 28
//    frame #10: 0x000000018a9d0668 CoreFoundation`__CFRunLoopDoSource0 + 208
//    frame #11: 0x000000018a9cf960 CoreFoundation`__CFRunLoopDoSources0 + 268
//    frame #12: 0x000000018a9c9a8c CoreFoundation`__CFRunLoopRun + 824
//    frame #13: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #14: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #15: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #16: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #17: 0x000000010009dbdc swift-study`main at AppDelegate.swift:12:7
//    frame #18: 0x000000018a6896b0 libdyld.dylib`start + 4


//
//  UIButton点击事件
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
//  * frame #0: 0x000000010025ded4 swift-study`-[RunLoopViewController tap](self=0x0000000105e07b70, _cmd="tap") at RunLoopViewController.m:62:5
//    frame #1: 0x000000018d40ef70 UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 100
//    frame #2: 0x000000018cd461c4 UIKitCore`-[UIControl sendAction:to:forEvent:] + 208
//    frame #3: 0x000000018cd46518 UIKitCore`-[UIControl _sendActionsForEvents:withEvent:] + 356
//    frame #4: 0x000000018cd44d7c UIKitCore`-[UIControl touchesEnded:withEvent:] + 536
//    frame #5: 0x000000018d44d5dc UIKitCore`-[UIWindow _sendTouchesForEvent:] + 988
//    frame #6: 0x000000018d44ef44 UIKitCore`-[UIWindow sendEvent:] + 3976
//    frame #7: 0x000000018d4282cc UIKitCore`-[UIApplication sendEvent:] + 712
//    frame #8: 0x000000018d4b21ec UIKitCore`__dispatchPreprocessedEventFromEventQueue + 7360
//    frame #9: 0x000000018d4b51a4 UIKitCore`__processEventQueue + 6460
//    frame #10: 0x000000018d4ac650 UIKitCore`__eventFetcherSourceCallback + 160
//    frame #11: 0x000000018a9d076c CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 28
//    frame #12: 0x000000018a9d0668 CoreFoundation`__CFRunLoopDoSource0 + 208
//    frame #13: 0x000000018a9cf960 CoreFoundation`__CFRunLoopDoSources0 + 268
//    frame #14: 0x000000018a9c9a8c CoreFoundation`__CFRunLoopRun + 824
//    frame #15: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #16: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #17: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #18: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #19: 0x0000000100279c24 swift-study`main at AppDelegate.swift:12:7
//    frame #20: 0x000000018a6896b0 libdyld.dylib`start + 4


//
//  UITapGestureRecognizer
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
//  * frame #0: 0x00000001020b5ec0 swift-study`-[RunLoopViewController tap:](self=0x000000010be60490, _cmd="tap:", gesture=0x000000010bf28150) at RunLoopViewController.m:57:5
//    frame #1: 0x000000018cf4daa8 UIKitCore`-[UIGestureRecognizerTarget _sendActionWithGestureRecognizer:] + 56
//    frame #2: 0x000000018cf5740c UIKitCore`_UIGestureRecognizerSendTargetActions + 116
//    frame #3: 0x000000018cf54048 UIKitCore`_UIGestureRecognizerSendActions + 284
//    frame #4: 0x000000018cf535c0 UIKitCore`-[UIGestureRecognizer _updateGestureForActiveEvents] + 636
//    frame #5: 0x000000018cf476ec UIKitCore`_UIGestureEnvironmentUpdate + 2000
//    frame #6: 0x000000018cf46a98 UIKitCore`-[UIGestureEnvironment _updateForEvent:window:] + 764
//    frame #7: 0x000000018d44ef28 UIKitCore`-[UIWindow sendEvent:] + 3948
//    frame #8: 0x000000018d4282cc UIKitCore`-[UIApplication sendEvent:] + 712
//    frame #9: 0x000000018d4b21ec UIKitCore`__dispatchPreprocessedEventFromEventQueue + 7360
//    frame #10: 0x000000018d4b51a4 UIKitCore`__processEventQueue + 6460
//    frame #11: 0x000000018d4ac650 UIKitCore`__eventFetcherSourceCallback + 160
//    frame #12: 0x000000018a9d076c CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 28
//    frame #13: 0x000000018a9d0668 CoreFoundation`__CFRunLoopDoSource0 + 208
//    frame #14: 0x000000018a9cf960 CoreFoundation`__CFRunLoopDoSources0 + 268
//    frame #15: 0x000000018a9c9a8c CoreFoundation`__CFRunLoopRun + 824
//    frame #16: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #17: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #18: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #19: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #20: 0x00000001020d1c20 swift-study`main at AppDelegate.swift:12:7
//    frame #21: 0x000000018a6896b0 libdyld.dylib`start + 4


//
//  dispatch_after main queue
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
//  * frame #0: 0x0000000104f85eb0 swift-study`-[RunLoopViewController tap](self=0x000000010b434fc0, _cmd="tap") at RunLoopViewController.m:66:5
//    frame #1: 0x0000000104f85e1c swift-study`__36-[RunLoopViewController viewDidLoad]_block_invoke(.block_descriptor=0x0000000281a6dbf0) at RunLoopViewController.m:61:9
//    frame #2: 0x00000001090dd6c0 libdispatch.dylib`_dispatch_client_callout + 20
//    frame #3: 0x00000001090e0668 libdispatch.dylib`_dispatch_continuation_pop + 584
//    frame #4: 0x00000001090f578c libdispatch.dylib`_dispatch_source_invoke + 1360
//    frame #5: 0x00000001090ecd7c libdispatch.dylib`_dispatch_main_queue_callback_4CF + 560
//    frame #6: 0x000000018a9d011c CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 16
//    frame #7: 0x000000018a9ca120 CoreFoundation`__CFRunLoopRun + 2508
//    frame #8: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #9: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #10: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #11: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #12: 0x0000000104fa1c00 swift-study`main at AppDelegate.swift:12:7
//    frame #13: 0x000000018a6896b0 libdyld.dylib`start + 4


//
//  dispatch_after global queue
//
//* thread #3, queue = 'com.apple.root.default-qos', stop reason = breakpoint 2.1
//  * frame #0: 0x00000001045fdeb0 swift-study`-[RunLoopViewController tap](self=0x000000010aa0c2d0, _cmd="tap") at RunLoopViewController.m:66:5
//    frame #1: 0x00000001045fde1c swift-study`__36-[RunLoopViewController viewDidLoad]_block_invoke(.block_descriptor=0x0000000282aa0c90) at RunLoopViewController.m:61:9
//    frame #2: 0x000000010875d6c0 libdispatch.dylib`_dispatch_client_callout + 20
//    frame #3: 0x0000000108760668 libdispatch.dylib`_dispatch_continuation_pop + 584
//    frame #4: 0x000000010877578c libdispatch.dylib`_dispatch_source_invoke + 1360
//    frame #5: 0x000000010875ff08 libdispatch.dylib`_dispatch_queue_override_invoke + 468
//    frame #6: 0x0000000108770ae0 libdispatch.dylib`_dispatch_root_queue_drain + 364
//    frame #7: 0x0000000108771488 libdispatch.dylib`_dispatch_worker_thread2 + 140
//    frame #8: 0x00000001d629f7c8 libsystem_pthread.dylib`_pthread_wqthread + 216

//
//  NSTimer
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 3.1
//  * frame #0: 0x0000000104205e28 swift-study`__36-[RunLoopViewController viewDidLoad]_block_invoke(.block_descriptor=0x0000000104290ff8, timer=0x0000000280189d40) at RunLoopViewController.m:68:9
//    frame #1: 0x000000018bdebb20 Foundation`__NSFireTimer + 68
//    frame #2: 0x000000018a9d0fa0 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 32
//    frame #3: 0x000000018a9d0ba0 CoreFoundation`__CFRunLoopDoTimer + 1064
//    frame #4: 0x000000018a9cfffc CoreFoundation`__CFRunLoopDoTimers + 328
//    frame #5: 0x000000018a9c9ee4 CoreFoundation`__CFRunLoopRun + 1936
//    frame #6: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #7: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #8: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #9: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #10: 0x0000000104221bf4 swift-study`main at AppDelegate.swift:12:7
//    frame #11: 0x000000018a6896b0 libdyld.dylib`start + 4

//
// GCD Timer main queue
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
//  * frame #0: 0x0000000100019cc8 swift-study`__36-[RunLoopViewController viewDidLoad]_block_invoke(.block_descriptor=0x00000001000a5030) at RunLoopViewController.m:77:13
//    frame #1: 0x00000001041796c0 libdispatch.dylib`_dispatch_client_callout + 20
//    frame #2: 0x000000010417c668 libdispatch.dylib`_dispatch_continuation_pop + 584
//    frame #3: 0x000000010419178c libdispatch.dylib`_dispatch_source_invoke + 1360
//    frame #4: 0x0000000104188d7c libdispatch.dylib`_dispatch_main_queue_callback_4CF + 560
//    frame #5: 0x000000018a9d011c CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 16
//    frame #6: 0x000000018a9ca120 CoreFoundation`__CFRunLoopRun + 2508
//    frame #7: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #8: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #9: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #10: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #11: 0x0000000100035b14 swift-study`main at AppDelegate.swift:12:7
//    frame #12: 0x000000018a6896b0 libdyld.dylib`start + 4


//
// GCD Timer global queue
//
//* thread #8, queue = 'com.apple.root.default-qos', stop reason = breakpoint 2.1
//  * frame #0: 0x00000001027d9cc8 swift-study`__36-[RunLoopViewController viewDidLoad]_block_invoke(.block_descriptor=0x0000000102865028) at RunLoopViewController.m:77:13
//    frame #1: 0x000000010694d6c0 libdispatch.dylib`_dispatch_client_callout + 20
//    frame #2: 0x0000000106950668 libdispatch.dylib`_dispatch_continuation_pop + 584
//    frame #3: 0x000000010696578c libdispatch.dylib`_dispatch_source_invoke + 1360
//    frame #4: 0x0000000106960ae0 libdispatch.dylib`_dispatch_root_queue_drain + 364
//    frame #5: 0x0000000106961488 libdispatch.dylib`_dispatch_worker_thread2 + 140
//    frame #6: 0x00000001d629f7c8 libsystem_pthread.dylib`_pthread_wqthread + 216


//
//  touchesBegan + UITapGestureRecognizer
//
//* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 4.1
//  * frame #0: 0x0000000100da5d44 swift-study`-[RunLoopViewController touchesCancelled:withEvent:](self=0x0000000107a0bc00, _cmd="touchesCancelled:withEvent:", touches=1 element, event=0x0000000280cdd380) at RunLoopViewController.m:116:5
//    frame #1: 0x000000018d43e924 UIKitCore`forwardTouchMethod + 344
//    frame #2: 0x000000018d43ea90 UIKitCore`-[UIResponder touchesCancelled:withEvent:] + 64
//    frame #3: 0x000000018d421294 UIKitCore`__106-[UIApplication _cancelViewProcessingOfTouchesOrPresses:withEvent:sendingCancelToViewsOfTouchesOrPresses:]_block_invoke + 500
//    frame #4: 0x000000018d420c58 UIKitCore`-[UIApplication _cancelTouchesOrPresses:withEvent:includingGestures:notificationBlock:] + 944
//    frame #5: 0x000000018d421060 UIKitCore`-[UIApplication _cancelViewProcessingOfTouchesOrPresses:withEvent:sendingCancelToViewsOfTouchesOrPresses:] + 204
//    frame #6: 0x000000018cf4bd40 UIKitCore`-[UIGestureEnvironment _cancelTouches:event:] + 644
//    frame #7: 0x000000018cf538ec UIKitCore`-[UIGestureRecognizer _updateGestureForActiveEvents] + 1448
//    frame #8: 0x000000018cf476ec UIKitCore`_UIGestureEnvironmentUpdate + 2000
//    frame #9: 0x000000018cf46a98 UIKitCore`-[UIGestureEnvironment _updateForEvent:window:] + 764
//    frame #10: 0x000000018d44ef28 UIKitCore`-[UIWindow sendEvent:] + 3948
//    frame #11: 0x000000018d4282cc UIKitCore`-[UIApplication sendEvent:] + 712
//    frame #12: 0x000000018d4b21ec UIKitCore`__dispatchPreprocessedEventFromEventQueue + 7360
//    frame #13: 0x000000018d4b51a4 UIKitCore`__processEventQueue + 6460
//    frame #14: 0x000000018d4ac650 UIKitCore`__eventFetcherSourceCallback + 160
//    frame #15: 0x000000018a9d076c CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 28
//    frame #16: 0x000000018a9d0668 CoreFoundation`__CFRunLoopDoSource0 + 208
//    frame #17: 0x000000018a9cf960 CoreFoundation`__CFRunLoopDoSources0 + 268
//    frame #18: 0x000000018a9c9a8c CoreFoundation`__CFRunLoopRun + 824
//    frame #19: 0x000000018a9c921c CoreFoundation`CFRunLoopRunSpecific + 600
//    frame #20: 0x00000001a24cd784 GraphicsServices`GSEventRunModal + 164
//    frame #21: 0x000000018d407fe0 UIKitCore`-[UIApplication _run] + 1072
//    frame #22: 0x000000018d40d854 UIKitCore`UIApplicationMain + 168
//    frame #23: 0x0000000100dc1ac0 swift-study`main at AppDelegate.swift:12:7
//    frame #24: 0x000000018a6896b0 libdyld.dylib`start + 4

//
//  main.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}
dispatch_source_t SIGTERMHandlerSource;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        signal(SIGTERM, SIG_IGN);
        
        SIGTERMHandlerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGTERM, 0, dispatch_get_main_queue());
        
        dispatch_source_set_event_handler(SIGTERMHandlerSource, ^{
            exit(0);
        });
        dispatch_resume(SIGTERMHandlerSource);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
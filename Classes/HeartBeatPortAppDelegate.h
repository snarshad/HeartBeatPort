//
//  HeartBeatPortAppDelegate.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBLoginViewController, HBHomeViewController;
@class Rdio;

@interface HeartBeatPortAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	IBOutlet HBLoginViewController *loginController;
	IBOutlet HBHomeViewController *homeController;
	Rdio *rdio;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


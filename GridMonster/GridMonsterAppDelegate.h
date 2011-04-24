//
//  GridMonsterAppDelegate.h
//  GridMonster
//
//  Created by Mark Lussier on 4/23/11.
//  Copyright 2011 Juniper Networks, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridMonsterViewController;

@interface GridMonsterAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GridMonsterViewController *viewController;

@end

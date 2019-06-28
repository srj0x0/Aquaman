//
//  AppDelegate.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "AppDelegate.h"
#import "BundleFinder.h"
#import "DefaultsManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter addObserver:NSApp
                                           selector:@selector(terminate:)
                                               name:NSWindowWillCloseNotification
                                             object:nil];
}

@end

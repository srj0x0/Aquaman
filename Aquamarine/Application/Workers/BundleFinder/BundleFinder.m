//
//  BundleFinder.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "BundleFinder.h"

@implementation BundleFinder

- (nonnull NSString *)bundleIDForApplicationAtPath:(NSString *)applicationPath {
    return [[[NSBundle alloc] initWithPath:applicationPath] bundleIdentifier];
}

@end

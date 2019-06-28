//
//  BundleFinderService.h
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BundleFinderService <NSObject>

- (NSString *)bundleIDForApplicationAtPath:(NSString *)applicationPath;

@end

NS_ASSUME_NONNULL_END

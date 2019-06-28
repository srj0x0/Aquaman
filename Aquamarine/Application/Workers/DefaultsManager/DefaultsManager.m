//
//  DefaultsManager.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "DefaultsManager.h"

static NSString * const kToggleAquaScriptName = @"ToggleAquaAppearance";

@implementation DefaultsManager

- (BOOL)writeAquaAppearanceConfig:(BOOL)requireAqua
                     forAppWithID:(nonnull NSString *)bundleID
                            error:(out NSError **_Nullable)error {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:kToggleAquaScriptName ofType:@"sh"];
    if (path) {
        NSTask *updateDefaultsTask = [NSTask new];
        updateDefaultsTask.launchPath = path;
        updateDefaultsTask.arguments = @[bundleID, requireAqua ? @"YES" : @"NO"];
        return [updateDefaultsTask launchAndReturnError:error];
    }
    return false;
}

@end

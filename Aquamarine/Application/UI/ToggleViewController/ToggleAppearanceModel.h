//
//  ToggleModel.h
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSPasteboardItem.h>
#import "BundleFinderService.h"
#import "DefaultsManagmentService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToggleAppearanceModel : NSObject

- (BOOL)setAquaAppearance:(BOOL)useAqua forAppsInPaseteboard:(NSPasteboard *)pasteboard
                                                       error:(out NSError **_Nullable)error;

@end

NS_ASSUME_NONNULL_END

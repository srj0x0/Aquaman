//
//  ToggleModel.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "ToggleAppearanceModel.h"

@interface ToggleAppearanceModel()

@property (nonatomic, strong) IBOutlet id <BundleFinderService> bundleIDFinder;
@property (nonatomic, strong) IBOutlet id <DefaultsManagmentService> defaultsManager;

@end

@implementation ToggleAppearanceModel

- (instancetype)initWithBundleIDFinder:(id <BundleFinderService>)bundleIDFinder
                    andDefaultsManager:(id <DefaultsManagmentService>)defaultsManager {
    self = [super init];
    if (self) {
        _bundleIDFinder = bundleIDFinder;
        _defaultsManager = defaultsManager;
    }
    return self;
}

- (BOOL)setAquaAppearance:(BOOL)useAqua forAppsInPaseteboard:(NSPasteboard *)pasteboard
                                                       error:(out NSError **_Nullable)error {
    
    NSMutableArray<NSString *> *applicationPaths = [NSMutableArray array];
    for (NSPasteboardItem *item in pasteboard.pasteboardItems) {
        NSData *path = [item dataForType: NSPasteboardTypeFileURL];
        NSURL *url = [[NSURL alloc] initWithDataRepresentation:path relativeToURL:nil];
        [applicationPaths addObject:url.path];
    }
    if (applicationPaths.count == 0) return NO;
    
    for (NSString *path in applicationPaths) {
        NSString *bundleID = [self.bundleIDFinder bundleIDForApplicationAtPath:path];
        [self.defaultsManager writeAquaAppearanceConfig:useAqua forAppWithID:bundleID error:error];
        
    }
    return YES;
}

@end

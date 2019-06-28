//
//  ToggleAppearanceViewController.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "ToggleAppearanceViewController.h"
#import "DragDropView.h"

@interface ToggleAppearanceViewController () <DragDropViewDelegate>

@property (nonatomic, strong) IBOutlet ToggleAppearanceModel *model;
@property (nonatomic, strong) IBOutlet DragDropView *aquaAppearanceView;
@property (nonatomic, strong) IBOutlet DragDropView *defaultAppearanceView;

@end

@implementation ToggleAppearanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aquaAppearanceView.delegate = self;
    self.defaultAppearanceView.delegate = self;
    [self.aquaAppearanceView startDropHandling];
    [self.defaultAppearanceView startDropHandling];
}

- (NSArray<NSPasteboardType> *)draggedTypesForDragDropView:(DragDropView *)dragDropView {
    return @[NSPasteboardTypeURL];
}

- (NSArray<Class> *)draggedObjectClassesForDragDropView:(DragDropView *)dragDropView {
    return @[NSURL.class];
}

- (NSDragOperation)decidedOperationForDraggingView:(DragDropView *)dragDropView {
    return NSDragOperationCopy;
}

-(NSDictionary<NSPasteboardReadingOptionKey,id> *)filteringOptionsForDragDropView:(DragDropView *)dragDropView {
    NSString *applicationTypeKey = (__bridge NSString *)kUTTypeApplicationBundle;
    return @{NSPasteboardURLReadingContentsConformToTypesKey : @[applicationTypeKey]};
}

- (BOOL)dragDropView:(DragDropView *)dragDropView didReceiveDataWithPasteboard:(NSPasteboard *)pasteboard
                                                                       atPoint:(NSPoint)point {
    
    NSError *error;
    BOOL setAqua = dragDropView == self.aquaAppearanceView;
    BOOL processed = [self.model setAquaAppearance:setAqua forAppsInPaseteboard:pasteboard error:&error];
    if (error) {
        [self presentError:error];
    }
    return processed;
}

@end

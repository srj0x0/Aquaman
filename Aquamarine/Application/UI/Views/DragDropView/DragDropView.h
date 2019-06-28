//
//  DragDropView.h
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class DragDropView;

@protocol DragDropViewDelegate <NSObject>

@required
- (NSArray<NSPasteboardType> *)draggedTypesForDragDropView:(DragDropView *)dragDropView;
- (NSArray<Class> *)draggedObjectClassesForDragDropView:(DragDropView *)dragDropView;
- (NSDragOperation)decidedOperationForDraggingView:(DragDropView *)dragDropView;

- (BOOL)dragDropView:(DragDropView *)dragDropView
   didReceiveDataWithPasteboard:(NSPasteboard*)pasteboard
                        atPoint:(NSPoint)point;

@optional
- (NSDictionary<NSPasteboardReadingOptionKey,id> *)filteringOptionsForDragDropView:(DragDropView *)dragDropView;
- (void)dragDropViewDidBeginDrag:(DragDropView *)dragDropView;
- (void)dragDropViewDidEndDrag:(DragDropView *)dragDropView;

@end

@interface DragDropView : NSView

@property (assign, nonatomic, readonly) BOOL isReceivingDrag;
@property (weak, nonatomic) id <DragDropViewDelegate> delegate;

- (void)startDropHandling;

@end

NS_ASSUME_NONNULL_END

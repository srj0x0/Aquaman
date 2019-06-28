//
//  DragDropView.m
//  Aquamarine
//
//  Created by Sergey Dokukin on 6/28/19.
//  Copyright © 2019 Sergey Dokukin. All rights reserved.
//

#import "DragDropView.h"

@interface DragDropView()

@property (nonatomic, assign, readwrite) BOOL isReceivingDrag;

@end

@implementation DragDropView
{
    struct {
        unsigned int filteringOptions:1;
        unsigned int didBeginDrag: 1;
        unsigned int didEndDrag:1;
    } delegateResponds;
}

- (NSDictionary<NSPasteboardReadingOptionKey,id> *)filteringOptions {
    return delegateResponds.filteringOptions ? [self.delegate filteringOptionsForDragDropView:self] : nil;
}

- (void)setDelegate:(id<DragDropViewDelegate>)delegate {
    if (delegate != self.delegate) {
        delegateResponds.filteringOptions = [delegate respondsToSelector:@selector(filteringOptionsForDragDropView:)];
        delegateResponds.didBeginDrag = [delegate respondsToSelector:@selector(dragDropViewDidEndDrag:)];
        delegateResponds.didEndDrag = [delegate respondsToSelector:@selector(dragDropViewDidBeginDrag:)];
        _delegate = delegate;
    }
}

- (BOOL)shouldAllowDrag:(id<NSDraggingInfo>)info {
    return [info.draggingPasteboard canReadObjectForClasses:[self.delegate draggedObjectClassesForDragDropView:self]
                                                    options:[self filteringOptions]];
}

- (void)setIsReceivingDrag:(BOOL)isReceivingDrag {
    _isReceivingDrag = isReceivingDrag;
    if (isReceivingDrag && delegateResponds.didBeginDrag) {
        [self.delegate dragDropViewDidBeginDrag:self];
    } else if (delegateResponds.didEndDrag) {
        [self.delegate dragDropViewDidEndDrag:self];
    }
}

- (void)startDropHandling {
    [self registerForDraggedTypes:[self.delegate draggedTypesForDragDropView:self]];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    BOOL isDraggingAllowed = [self shouldAllowDrag:sender];
    self.isReceivingDrag = isDraggingAllowed;
    return isDraggingAllowed ? [self.delegate decidedOperationForDraggingView:self] : NSDragOperationNone;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    self.isReceivingDrag = NO;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return [self shouldAllowDrag:sender];
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    self.isReceivingDrag = NO;
    
    return [self.delegate dragDropView:self didReceiveDataWithPasteboard:sender.draggingPasteboard
                                                                 atPoint:sender.draggingLocation];
}

@end

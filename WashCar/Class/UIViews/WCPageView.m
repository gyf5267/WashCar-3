//
//  WCPageView.m
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCPageView.h"

@implementation WCPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.views = [NSMutableArray array];
    }
    return self;
}

- (void)setIndex:(NSUInteger)index {
    if (index!=_index) {
        _index = index;
        [self reload];
    }
}

- (void)setCount:(NSUInteger)count {
    if (count!=_count) {
        _count = count;
        [self reload];
    }
}

- (void)setUnitSize:(CGSize)unitSize {
    if (!CGSizeEqualToSize(unitSize, _unitSize)) {
        _unitSize = unitSize;
        [self reload];
    }
}

- (void)setNormalColor:(UIColor *)normalColor {
    if (normalColor!=_normalColor) {
        _normalColor = normalColor;
        [self reload];
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    if (selectedColor!=_selectedColor) {
        _selectedColor = selectedColor;
        [self reload];
    }
}

- (void)reload {
    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    
    CGFloat interval = _count>1?(self.bounds.size.width-_unitSize.width*_count)/(_count-1):0;
    
    for (int i=0,x=0; i<_count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, (self.bounds.size.height-_unitSize.height)/2, _unitSize.width, _unitSize.height)];
        if (i==self.index) {
            view.backgroundColor = self.selectedColor;
            view.alpha = 1.;
        } else {
            view.backgroundColor = self.normalColor;
            view.alpha = .7;
        }
        view.layer.cornerRadius = view.bounds.size.width/2;
        x+=_unitSize.width+interval;
        [self addSubview:view];
        [self.views addObject:view];
    }
}

@end

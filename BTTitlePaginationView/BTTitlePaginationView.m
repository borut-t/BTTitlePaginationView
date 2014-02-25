//
//  BTTitlePaginationView.m
//
//  Version 1.0
//
//  Created by Borut Tomazin on 2/25/2014.
//  Copyright 2014 Borut Tomazin
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/borut-t/BTTitlePaginationView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "BTTitlePaginationView.h"

CGFloat const ITEMS_HEIGHT = 20.f;

@interface BTTitlePaginationView ()

@property (nonatomic, strong) UILabel *titleLabelLeft;
@property (nonatomic, strong) UILabel *titleLabelCenter;
@property (nonatomic, strong) UILabel *titleLabelRight;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *itemsContainerView;

@property (nonatomic, assign) CGFloat previousOffset;

@end

@implementation BTTitlePaginationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2.f - 25.f,
                                                                       ITEMS_HEIGHT + 8.f,
                                                                       50.f,
                                                                       10.f)];
    self.pageControl.userInteractionEnabled = NO;
    [self setIndicatorTintColor:[UIColor grayColor]];
    [self setCurrentIndicatorTintColor:[UIColor whiteColor]];
    [self addSubview:self.pageControl];
    
    self.fadeInSpeed = 0.5f;
    self.fadeOutSpeed = 1.2f;
    
    self.clipsToBounds = YES;
}

- (void)setIndicatorTintColor:(UIColor *)indicatorTintColor
{
    if ([self.pageControl respondsToSelector:@selector(pageIndicatorTintColor)]) {
        self.pageControl.pageIndicatorTintColor = indicatorTintColor;
    }
}

- (void)setCurrentIndicatorTintColor:(UIColor *)currentIndicatorTintColor
{
    if ([self.pageControl respondsToSelector:@selector(currentPageIndicatorTintColor)]) {
        self.pageControl.currentPageIndicatorTintColor = currentIndicatorTintColor;
    }
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    if (self.itemsContainerView == nil) {
        self.itemsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.frame), ITEMS_HEIGHT)];
        [self addSubview:self.itemsContainerView];
    }
    
    CGRect itemsContainerViewFrame = self.itemsContainerView.frame;
    itemsContainerViewFrame.size.width = itemsContainerViewFrame.size.width * _items.count;
    self.itemsContainerView.frame = itemsContainerViewFrame;
    
    self.pageControl.numberOfPages = _items.count;
    self.pageControl.currentPage = 0;
    
    CGFloat offsetX = 0.f;
    
    for (NSString *item in _items) {
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 5.f, CGRectGetWidth(self.frame), 20.f)];
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.textAlignment = UITextAlignmentCenter;
        itemLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
        itemLabel.text = item;
        //clear backgroundColor on iOS < 7.0
        if (![[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            itemLabel.backgroundColor = [UIColor clearColor];
        }
        
        [self.itemsContainerView addSubview:itemLabel];
        
        offsetX += CGRectGetWidth(self.frame);
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    self.pageControl.currentPage = _currentPage;
    
    [self setItemAlpha:1.f atIndex:self.currentPage];
    if (self.currentPage-1 > 0) {
        [self setItemAlpha:0.f atIndex:self.currentPage-1];
    }
    if (self.currentPage+1 < self.items.count) {
        [self setItemAlpha:0.f atIndex:self.currentPage+1];
    }
}

- (void)setOffset:(CGFloat)offset
{
    _offset = (offset - _previousOffset)/2.f * CGRectGetWidth(self.frame)/160.f;
    _previousOffset = offset;
    
    CGRect itemsContainerFrame = self.itemsContainerView.frame;
    itemsContainerFrame.origin.x -= _offset;
    self.itemsContainerView.frame = itemsContainerFrame;
    
    CGFloat containerOffsetX = itemsContainerFrame.origin.x*-1.f;
    if (containerOffsetX <= 0.f || containerOffsetX >= CGRectGetWidth(self.frame)*(self.items.count-1)) {
        return;
    }
    
    //current page
    CGFloat velocityCurrent = fabs(_offset/100.f * self.fadeOutSpeed);
    UILabel *currentItemLabel = [self itemAtIndex:self.currentPage];
    CGFloat currentItemLabelAlpha = currentItemLabel.alpha - velocityCurrent;
    if (currentItemLabelAlpha >= 0.f && currentItemLabelAlpha <= 1.f) {
        currentItemLabel.alpha = currentItemLabelAlpha;
    }
    
    //next/previous page
    CGFloat velocityNext = fabs(_offset/100.f * self.fadeInSpeed);
    UILabel *nextItemLabel = [self itemAtIndex:self.currentPage+(_offset > 0.f ? 1 : -1)];
    CGFloat nextItemLabelAlpha = nextItemLabel.alpha + velocityNext;
    if (nextItemLabelAlpha >= 0.f && nextItemLabelAlpha <= 1.f) {
        nextItemLabel.alpha = nextItemLabelAlpha;
    }
}

- (UILabel *)itemAtIndex:(NSUInteger)index
{
    return self.itemsContainerView.subviews.count > index ? self.itemsContainerView.subviews[index] : nil;
}

- (void)setItemAlpha:(CGFloat)alpha atIndex:(NSUInteger)index
{
    UILabel *label = [self itemAtIndex:index];
    label.alpha = alpha;
}

@end

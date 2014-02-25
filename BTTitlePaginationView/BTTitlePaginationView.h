//
//  BTTitlePaginationView.h
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

#import <UIKit/UIKit.h>

@interface BTTitlePaginationView : UIView

/**
 Current pagination page.
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 Scrolling offset retrieved from scrollView's property contentOffset.x
 */
@property (nonatomic, assign) CGFloat offset;

/**
 Pagination items array.
 */
@property (nonatomic, copy) NSArray *items;

/**
 Fade in speed (default 0.5).
 */
@property (nonatomic, assign) CGFloat fadeInSpeed;

/**
 Fade out speed (default 1.2).
 */
@property (nonatomic, assign) CGFloat fadeOutSpeed;

/**
 Pagination indicator tintColor (iOS 7.0+ only).
 */
@property (nonatomic, strong) UIColor *indicatorTintColor;

/**
 Pagination current indicator tintColor (iOS 7.0+ only).
 */
@property (nonatomic, strong) UIColor *currentIndicatorTintColor;

@end

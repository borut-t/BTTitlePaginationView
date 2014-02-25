## Purpose
Twitter-like title pagination view.


## ARC Support
BTTitlePaginationView fully supports ARC.


## Supported OS
iOS 5+


## Installation
Add `pod ‘BTTitlePaginationView’` to your Podfile or drag class files into your project.



## Properties
	@property (nonatomic, assign) NSInteger currentPage;

Current pagination page.

	@property (nonatomic, assign) CGFloat offset;

Scrolling offset retrieved from scrollView's property contentOffset.x

	@property (nonatomic, copy) NSArray *items;

Pagination items array.

	@property (nonatomic, assign) CGFloat fadeInSpeed;

Fade in speed (default 0.5).

	@property (nonatomic, assign) CGFloat fadeOutSpeed;

Fade out speed (default 1.2).

	@property (nonatomic, strong) UIColor *indicatorTintColor;

Pagination indicator tintColor (only iOS 7.0+).

	@property (nonatomic, strong) UIColor *currentIndicatorTintColor;

Pagination current indicator tintColor (only iOS 7.0+).
//
//  ViewController.m
//  BTTitlePaginationViewExample
//
//  Created by Borut Tomažin on 25. 02. 14.
//  Copyright (c) 2014 Borut Tomazin. All rights reserved.
//

#import "ViewController.h"
#import "BTTitlePaginationView.h"

@interface ViewController ()

@property (nonatomic, strong) BTTitlePaginationView *titlePaginationView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.titlePaginationView = [[BTTitlePaginationView alloc] initWithFrame:CGRectMake(0.f, 0.f, 140.f, 44.f)];
    self.titlePaginationView.items = @[@"Page 1", @"Page 2", @"Page 3", @"Page 4", @"Page 5"];
    self.titlePaginationView.currentPage = 0;
    self.navigationItem.titleView = self.titlePaginationView;
    
    [self layoutItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self layoutItems];
}


#pragma mark - Custom methods
- (void)layoutItems
{
    int index = 0;
    for (NSString *item in self.titlePaginationView.items) {
        if ([self.scrollView viewWithTag:10+index] == nil) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label.text = item;
            label.tag = 10+index;
            label.textAlignment = UITextAlignmentCenter;
            [self.scrollView addSubview:label];
        }
        
        [(UILabel *)[self.scrollView viewWithTag:10+index] setFrame:CGRectMake(CGRectGetWidth(self.view.frame)*index,
                                                                               100.f,
                                                                               CGRectGetWidth(self.view.frame),
                                                                               30.f)];
        
        index++;
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.titlePaginationView.items.count, 0);
}



#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.titlePaginationView.currentPage = page;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.titlePaginationView.offset = scrollView.contentOffset.x;
}

@end

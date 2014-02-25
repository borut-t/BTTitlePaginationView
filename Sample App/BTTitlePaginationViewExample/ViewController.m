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
    self.titlePaginationView.items = @[@"Page 1", @"Page 2", @"Page 3"];
    self.titlePaginationView.fadeInSpeed = 0.8f;
    self.titlePaginationView.currentPage = 0;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 3, 0);
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 100.f, 300.f, 30.f)];
    label1.text = @"Page 1";
    label1.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(330.f, 100.f, 300.f, 30.f)];
    label2.text = @"Page 2";
    label2.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(650.f, 100.f, 300.f, 30.f)];
    label3.text = @"Page 3";
    label3.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:label3];
    
    self.navigationItem.titleView = self.titlePaginationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

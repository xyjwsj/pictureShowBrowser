//
//  PictureBrowserViewController.m
//  picmatrix
//
//  Created by Hoolai on 16/8/1.
//  Copyright © 2016年 wsj_proj. All rights reserved.
//

#import "PictureBrowserViewController.h"

@interface PictureBrowserViewController ()

@end

@implementation PictureBrowserViewController {
    CGFloat startOffsetX;
}

-(instancetype)initWithDataSource:(NSArray *)dataSource {
    if (self = [super init]) {
        _dataSource = [dataSource copy];
        startOffsetX = 0;
        _currentShowIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInController:(UIViewController*)showViewController index:(NSInteger)index{
    [showViewController addChildViewController:self];
    [showViewController.view addSubview:self.view];
    _currentShowIndex = index;
}

- (void)dismiss {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma initView

-(void)setupView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * [_dataSource count], self.view.bounds.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * _currentShowIndex, 0)];
    [self.view addSubview:_scrollView];
    [self reloadData];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 40, _scrollView.frame.size.width, 40)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.numberOfPages = _dataSource.count;
    _pageControl.currentPage = _currentShowIndex;
    [self.view addSubview:_pageControl];
}

- (void)reloadData {
    UIImageView* imageView = nil;
    for (int i = 0; i < [_dataSource count]; i++) {
        NSObject* obj = [_dataSource objectAtIndex:i];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        if ([obj isKindOfClass:[NSString class]]) {
            [imageView setImage:[UIImage imageNamed:(NSString*)obj]];
        }
        [_scrollView addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        UIGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [imageView addGestureRecognizer:singleTap];
    }
}

-(void)imageTap:(UITapGestureRecognizer*)sender {
    [self dismiss];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat endOffsetX = scrollView.contentOffset.x;
    NSInteger pages = [_dataSource count];
    BOOL leftAnimation = endOffsetX - startOffsetX < 0 ? YES : NO;
    if (leftAnimation && pages - 1 >= 0) {
        _pageControl.currentPage = _pageControl.currentPage - 1;
    }
    if (!leftAnimation && _pageControl.currentPage < pages) {
        _pageControl.currentPage = _pageControl.currentPage + 1;
    }
}

@end

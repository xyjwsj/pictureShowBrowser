//
//  PictureBrowserViewController.h
//  picmatrix
//
//  Created by Hoolai on 16/8/1.
//  Copyright © 2016年 wsj_proj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureMatrixView.h"

@interface PictureBrowserViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, copy) NSArray* dataSource;

@property (nonatomic, retain) UIScrollView* scrollView;

@property (nonatomic, retain) UIPageControl* pageControl;

@property (nonatomic, assign) NSInteger currentShowIndex;

- (instancetype)initWithDataSource:(NSArray*)dataSource;

- (void)showInController:(UIViewController*)showViewController index:(NSInteger)index picMatrixView:(PictureMatrixView*)picMatrixView;

- (void)dismiss;

@end

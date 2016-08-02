//
//  ViewController.m
//  picmatrix
//
//  Created by Hoolai on 16/7/30.
//  Copyright © 2016年 wsj_proj. All rights reserved.
//

#import "ViewController.h"
#import "PictureMatrixView.h"
#import "PictureBrowserViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    PictureMatrixView* matrixView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PicMatrix picMatrix;
    picMatrix.column = 4;
    picMatrix.row = 0;
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:5];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    [array addObject:@"blue"];
    
    __block ViewController* weakSelf = self;
    
    matrixView = [[PictureMatrixView alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-100, 200) picSource:array picMatrix:picMatrix tapCallback:^(NSInteger index, NSArray *picArray) {
        NSLog(@"index=%@", @(index));
        [weakSelf openPicBrowser:picArray index:index];
    }];
    matrixView.rate = 3.0/4.0;
    
    [self.view addSubview:matrixView];
    
}

- (void)openPicBrowser:(NSArray*)picArray index:(NSInteger)index{
    [[[PictureBrowserViewController alloc] initWithDataSource:picArray] showInController:self index:index picMatrixView:matrixView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

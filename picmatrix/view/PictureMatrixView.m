//
//  PictureMatrixView.m
//  picmatrix
//
//  Created by Hoolai on 16/7/30.
//  Copyright © 2016年 wsj_proj. All rights reserved.
//

#import "PictureMatrixView.h"

@implementation PictureMatrixView {
    PicTap picTap;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame picSource:(NSArray *)picSource picMatrix:(PicMatrix)picMatrix tapCallback:(PicTap)tapCallback {
    if (self = [super initWithFrame:frame]) {
        _picArray = picSource;
        _picMatrix = picMatrix;
        picTap = tapCallback;
        [self setupView:1];
    }
    return self;
}

- (void)setRate:(CGFloat)rate {
    [self setupView:rate];
}

- (void)setupView:(CGFloat)rate {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.backgroundColor = [UIColor redColor];
    
    CGFloat width = self.frame.size.width;
    
    
    NSInteger count = [_picArray count];
    
    UIImageView* imageView = nil;
    
    NSInteger column = count < _picMatrix.column ? count : _picMatrix.column;
    
    CGFloat picWidth = (width - (column + 1) * PicMatrix_GAP) / column;
    CGFloat picHeight = picWidth / rate;
    
    for (int i = 0; i < count; i++) {
        NSObject* obj = [_picArray objectAtIndex:i];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(PicMatrix_GAP + (i%column) * (PicMatrix_GAP + picWidth), floorf(i/(float)column) * (PicMatrix_GAP + picHeight) + PicMatrix_GAP, picWidth, picHeight)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        if ([obj isKindOfClass:[NSString class]]) {
            [imageView setImage:[UIImage imageNamed:(NSString*)obj]];
        }
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UIGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [imageView addGestureRecognizer:singleTap];
    }
    
    NSInteger row = ceilf(count/(float)column);
    
    CGFloat totalHeight = (picHeight + PicMatrix_GAP) * row + PicMatrix_GAP;
    
    CGRect frame = self.frame;
    frame.size.height = totalHeight;
    self.frame = frame;
}

-(void)imageTap:(UITapGestureRecognizer*)sender {
    UIImageView* imageView = (UIImageView*)sender.view;
    if (picTap) {
        picTap(imageView.tag, _picArray);
    }
}

@end

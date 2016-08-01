//
//  PictureMatrixView.h
//  picmatrix
//
//  Created by Hoolai on 16/7/30.
//  Copyright © 2016年 wsj_proj. All rights reserved.
//

#import <UIKit/UIKit.h>

struct PicMatrix {
    int row; //固定行时非0，非固定时为0
    int column;
};

typedef struct PicMatrix PicMatrix;

typedef void (^PicTap) (NSInteger index, NSArray* picArray);

#define PicMatrix_GAP 5

@interface PictureMatrixView : UIView

/**
 *  图片数组
 */
@property (nonatomic, retain) NSArray* picArray;


/**
 *  图片显示宽高比例
 */
@property (nonatomic, assign) CGFloat rate;

/**
 *  图片显示行列
 */
@property (nonatomic) PicMatrix picMatrix;


- (instancetype)initWithFrame:(CGRect)frame picSource:(NSArray*)picSource picMatrix:(PicMatrix)picMatrix tapCallback:(PicTap)tapCallback;

@end

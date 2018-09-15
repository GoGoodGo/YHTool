//
//  YHScrollView.h
//
//  Created by YH_O on 16/6/16.
//  Copyright © 2016年 OYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHScrollView : UIView
/**
 *  图片 URL 数组
 */
@property (nonatomic, strong) NSArray<NSString *> *imgURLArr;
/**
 *  图片 Name 数组
 */
@property (nonatomic, strong) NSArray<NSString *> *imgNameArray;
/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray<UIImage *> *imgArray;
/**
 *  当前选中指示器的颜色
 */
@property (nonatomic, strong) UIColor *currentIndicatorColor;
/**
 *  未选中指示器的颜色
 */
@property (nonatomic, strong) UIColor *otherIndicatorColor;
/**
 *  指示器的Frame
 */
@property (nonatomic, assign) CGRect indicatorFrame;
/**
 *  是否自适应图片大小
 */
@property (nonatomic, assign) BOOL isAutoSize;
/**
 * 是否循环,默认YES
 */
@property (nonatomic, assign) BOOL isCircle;
/**
 * 是否自动滚动,默认YES
 */
@property (nonatomic, assign) BOOL isAutoScroll;
/**
 * 是否回弹
 */
@property (nonatomic, assign) BOOL isSpringback;
/**
 * tap 图片回调
 */
@property (nonatomic, copy) void(^tapImgBlock)(NSInteger index);
/**
 *  初始化 scrollView 并传入图片名字数组
 *
 *  @param frame         frame
 *  @param imgNamesArray imageName 数组
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSArray<NSString *> *)imgNamesArray;

/**
 全屏展示图片

 @param frame 初始位置和大小
 @param imgArray 展示的图片数组
 @param index 当前点击的图片 index
 */
- (void)setupFullScreenWithFrame:(CGRect)frame imgArray:(NSArray<UIImage *> *)imgArray index:(NSUInteger)index;











@end

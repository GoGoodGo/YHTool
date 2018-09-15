//
//  YHPullDownView.h
//  HengQin
//
//  Created by YH_O on 2017/1/6.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPullDownView : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, assign) NSInteger showRow;
@property (nonatomic, assign, readonly) BOOL isOpen;
@property (nonatomic, assign) BOOL isDefaultSelected; // 是否默认选中
@property (nonatomic, assign) BOOL isSelectedClose; // 是否选中行不自动关闭
@property (nonatomic, assign) BOOL isSelectedCancel; // 是否选中自动取消

@property (nonatomic, copy) void(^selectedRowBlock)(NSString *title, NSInteger index);

/**
 打开 pullDownView
 */
- (void)onlyOpenPullDownView;
/**
 打开 or 关闭 pullDownView
 */
- (void)openPullDownView;

/**
 关闭 pullDownView
 */
- (void)closePullDownView;

@end

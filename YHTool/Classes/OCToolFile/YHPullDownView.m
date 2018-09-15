//
//  YHPullDownView.m
//  HengQin
//
//  Created by YH_O on 2017/1/6.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "YHPullDownView.h"
#import "PullDownCell.h"

#define YHRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

static NSString * const PullDownViewIdentifier = @"pullDownViewCell";
static const CGFloat _pullDownCellH = 45;
static const CGFloat _animationDuration = 0.5f;
static const NSInteger _defaultRow = 4;


@interface YHPullDownView ()<UITableViewDelegate, UITableViewDataSource> {
    
    NSIndexPath *_pastIndexPath;
    NSInteger _row;
}
@property (nonatomic, strong) UITableView *pullDownView;
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation YHPullDownView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self layoutCustomSubviews];
    }
    return self;
}

- (void)layoutCustomSubviews {
    
    self.backgroundColor = [UIColor lightGrayColor];
    _row = _defaultRow;
    self.isSelectedClose = YES;
    [self addSubview:self.pullDownView];
    if (self.isDefaultSelected) {
        _pastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else {
        _pastIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    }
}

- (void)onlyOpenPullDownView {
    _isOpen = NO;
    [self openPullDownView];
}
// 显示 pullDownView
- (void)openPullDownView {
    
    if (!_isOpen) {
        if (!self.isSelectedCancel) {
            [self.pullDownView selectRowAtIndexPath:_pastIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        _isOpen = YES;
        NSInteger count = self.titles.count;
        if (count > _row) {
            count = _row;
        }
        CGFloat height = _pullDownCellH * count;
        __block CGRect frame = self.frame;
        __block CGRect tableViewFrame = self.pullDownView.frame;
        tableViewFrame.size.width = frame.size.width;
        self.pullDownView.frame = tableViewFrame;
        [UIView animateWithDuration:_animationDuration animations:^{
            
            frame.size.height = height;
            tableViewFrame.size.height = height;
            self.frame = frame;
            self.pullDownView.frame = tableViewFrame;
        }];
    } else {
        [self closePullDownView];
    }
}

- (void)closePullDownView {
    
    _isOpen = NO;
    [UIView animateWithDuration:_animationDuration animations:^{
        
        CGRect frame = self.frame;
        CGRect tableViewFrame = self.pullDownView.frame;
        frame.size.height = 0;
        tableViewFrame.size.height = 0;
        self.frame = frame;
        self.pullDownView.frame = tableViewFrame;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}
// tableView width = 0 此方法不会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PullDownCell *cell = [tableView dequeueReusableCellWithIdentifier:PullDownViewIdentifier];
    cell.title = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath == _pastIndexPath) return;
    if (self.isSelectedCancel) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if (self.isSelectedClose) {
        [self closePullDownView];
    }
    _pastIndexPath = indexPath;
    
    if (self.selectedRowBlock) {
        NSString *title = self.titles[indexPath.row];
        self.selectedRowBlock(title, indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _pullDownCellH;
}

#pragma mark - Setter

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    [self.pullDownView reloadData];
}

- (void)setShowRow:(NSInteger)showRow {
    
    _showRow = showRow;
    _row = showRow;
}

#pragma mark - Getter

- (UITableView *)pullDownView {
    
    if (!_pullDownView) {
        _pullDownView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
        _pullDownView.dataSource = self;
        _pullDownView.delegate = self;
        _pullDownView.showsVerticalScrollIndicator = NO;
        _pullDownView.backgroundColor = YHRGBColor(245, 245, 245);
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"YHTool" withExtension:@"bundle"];
        [_pullDownView registerNib:[UINib nibWithNibName:NSStringFromClass([PullDownCell class]) bundle:[NSBundle bundleWithURL:url]] forCellReuseIdentifier:PullDownViewIdentifier];
        _pullDownView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _pullDownView;
}













@end

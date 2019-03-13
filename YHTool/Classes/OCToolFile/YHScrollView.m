//
//  YHScrollView.m
//  OSHI
//
//  Created by YH_O on 16/6/16.
//  Copyright © 2016年 OYH. All rights reserved.
//

#import "YHScrollView.h"
#import "UIImageView+WebCache.h"

static NSTimeInterval animationInterval = 2.f;
static NSTimeInterval fullScreenInterval = 0.2f;
// Width & Height
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@interface YHScrollView ()<UIScrollViewDelegate> {
    
    NSInteger _imageCount;
    NSInteger _currentImgIndex;
    CGFloat _oneSelfWidth;
    CGFloat _oneSelfHeight;
    BOOL _isFullScreen;
    CGRect _initialFrame;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation YHScrollView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSArray<NSString *> *)imgNamesArray {
    
    if (self = [super initWithFrame:frame]) {
        
        self.isCircle = YES;
        self.isAutoScroll = YES;
        _oneSelfWidth = CGRectGetWidth(self.bounds);
        _oneSelfHeight = CGRectGetHeight(self.bounds);
        [self setupSubViewsWithImgNameUrlArray:imgNamesArray];
    }
    return self;
}
#pragma mark - Custom Methods
/** 初始化 imgNameUrlArray:(图片url 或 图片名字)*/
- (void)setupSubViewsWithImgNameUrlArray:(NSArray<NSString *> *)imgNameUrlArray {
    
    if (imgNameUrlArray == nil || imgNameUrlArray.count <= 0) return;
    [self setupWithArray:imgNameUrlArray];
    
    NSString *imgStr = [imgNameUrlArray firstObject];
    if ([imgStr hasPrefix:@"http"]) {
        [self disposeImgUrlArray:imgNameUrlArray];
    } else {
        [self setupImgViewWithArray:[self disposeImgViewWithImgNameArray:imgNameUrlArray]];
    }
}
/** 初始化 imgArray: (UIImage *) */
- (void)setupSubViewsWithImgArray:(NSArray<UIImage *> *)imgArray {
    
    [self setupWithArray:imgArray];
    [self setupImgViewWithArray:[self disposeImgViewWithImgArray:imgArray]];
}
/** 初始化配置 */
- (void)setupWithArray:(NSArray *)array {
    
    if (array.count > 1) {
        if (self.isAutoScroll) {
            [self startTimer];
        }
        self.pageControl.numberOfPages = array.count;
    } else {
        self.pageControl.numberOfPages = 0;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)imgViewWithUrl:(NSArray *)urls index:(NSInteger)index imgViews:(NSMutableArray *)imgViews {
    
    __block NSInteger flag = index;
    self.imageView = [[UIImageView alloc] init];
    if (self.isAutoSize) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:urls[index]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            flag ++;
            CGFloat ratio = 0.f;
            if (image.size.height > self->_oneSelfHeight) {
                ratio = self->_oneSelfHeight / image.size.height;
            } else {
                ratio = image.size.height / self->_oneSelfHeight;
            }
            CGFloat width = image.size.width > self->_oneSelfWidth ? image.size.width * ratio : image.size.width;
            CGFloat height = image.size.height > self->_oneSelfHeight ? image.size.height * ratio : image.size.height;
            self.imageView.bounds = CGRectMake(0, 0, width, height);
            [imgViews addObject:self.imageView];
            if (flag == urls.count) {
                if (urls.count > 1 && self.isCircle) {
                    [self getTotalImgArrayWith:imgViews];
                } else {
                    [self setupImgViewWithArray:imgViews];
                }
            } else {
                [self imgViewWithUrl:urls index:flag imgViews:imgViews];
            }
        }];
    } else {
        self.imageView.frame = CGRectMake(_oneSelfWidth * index, 0, _oneSelfWidth, _oneSelfHeight);
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:urls[index]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            flag ++;
            [imgViews addObject:self.imageView];
            if (flag == urls.count) {
                if (urls.count > 1 && self.isCircle) {
                    [self getTotalImgArrayWith:imgViews];
                } else {
                    [self setupImgViewWithArray:imgViews];
                }
            } else {
                [self imgViewWithUrl:urls index:flag imgViews:imgViews];
            }
        }];
    }
}

/** 传入 url 数组设置 imgView  */
- (void)disposeImgUrlArray:(NSArray *)imgUrlArray {
    
    NSMutableArray *imgViewArray = [NSMutableArray arrayWithCapacity:imgUrlArray.count];
    [self imgViewWithUrl:imgUrlArray index:0 imgViews:imgViewArray];
}
/** 获取循环滚动最终 ImgView 数组 */
- (NSArray *)getTotalImgArrayWith:(NSArray<UIImageView *> *)imgViewArray {
    
    if (imgViewArray.count <= 0) return imgViewArray;
    UIImageView *a = [imgViewArray firstObject];
    UIImageView *b = [imgViewArray lastObject];
    UIImageView *firstObj = [[UIImageView alloc] initWithImage:a.image];
    firstObj.frame = a.frame;
    UIImageView *lastObj = [[UIImageView alloc] initWithImage:b.image];
    lastObj.frame = b.frame;
    
    [self.imageArray addObject:lastObj];
    for (NSInteger index = 0; index < imgViewArray.count; ++ index) {
        [self.imageArray addObject:imgViewArray[index]];
    }
    [self.imageArray addObject:firstObj];
    
    if (self.isCircle) {
        self.scrollView.contentOffset = CGPointMake(_oneSelfWidth, 0);
        [self setupImgViewWithArray:self.imageArray];
    }
    return self.imageArray;
}
/** 获取 imgView(image) 数组*/
- (NSArray *)disposeImgViewWithImgArray:(NSArray<UIImage *> *)imgArray {
    NSMutableArray *imgViewArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    for (NSInteger index = 0; index < imgArray.count; ++ index) {
        UIImage *image = imgArray[index];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        if (!_isFullScreen) {
            imgView.frame = CGRectMake(_oneSelfWidth * index, 0, _oneSelfWidth, _oneSelfHeight);
        } else {
            CGFloat ratio = 0.f;
            ratio = SCREEN_WIDTH / image.size.width;
            CGFloat height = image.size.height * ratio;
            imgView.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, height);
        }
        [imgViewArray addObject:imgView];
    }
    if (self.isCircle) {
        return [self getTotalImgArrayWith:imgViewArray];
    }
    return imgViewArray;
}
/** 获取 imgView(imageName) 数组*/
- (NSArray *)disposeImgViewWithImgNameArray:(NSArray<NSString *> *)imgNameArray {
    NSMutableArray *imgViewArray = [NSMutableArray arrayWithCapacity:imgNameArray.count];
    for (NSInteger index = 0; index < imgNameArray.count; ++ index) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_oneSelfWidth * index, 0, _oneSelfWidth, _oneSelfHeight)];
        imgView.image = [UIImage imageNamed:imgNameArray[index]];
        [imgViewArray addObject:imgView];
    }
    if (self.isCircle) {
        return [self getTotalImgArrayWith:imgViewArray];
    }
    return imgViewArray;
}
/** 设置 imgView */
- (void)setupImgViewWithArray:(NSArray<UIImageView *> *)imgViewArray {
    
    _imageCount = imgViewArray.count;
    if (!_isFullScreen) {
        self.scrollView.contentSize = CGSizeMake(_oneSelfWidth * _imageCount, _oneSelfHeight);
    } else {
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageCount, SCREEN_HEIGHT);
    }
    for (NSInteger index = 0; index < _imageCount; ++ index) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_imgTap)];
        UIImageView *imgView = imgViewArray[index];
        if (!_isFullScreen) {
            imgView.center = CGPointMake(_oneSelfWidth / 2 + _oneSelfWidth * index, _oneSelfHeight / 2);
        } else {
            imgView.center = CGPointMake(SCREEN_WIDTH / 2 + SCREEN_WIDTH * index, SCREEN_HEIGHT / 2);
        }
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tapGesture];
        
        [self.scrollView addSubview:imgView];
    }
}
#pragma mark - 全屏展示图片
// 全屏展示图片位置问题
- (void)setupFullScreenWithFrame:(CGRect)frame imgArray:(NSArray<UIImage *> *)imgArray index:(NSUInteger)index {
    _isFullScreen = YES;
    self.hidden = NO;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _initialFrame =  frame;
    self.scrollView.frame = _initialFrame;
    [self setupSubViewsWithImgArray:imgArray];
    if (self.isCircle) {
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (index + 1), 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
    }
    [UIView animateWithDuration:fullScreenInterval animations:^{
       
        self.scrollView.frame = self.frame;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 1.f;
    }];
    self.pageControl.currentPage = index;
}
/** tap 缩小全屏 */
- (void)cancelFullScreen {
    [UIView animateWithDuration:fullScreenInterval animations:^{
       
        self.scrollView.frame = self->_initialFrame;
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.scrollView removeFromSuperview];
        self.scrollView = nil;
    }];
}

#pragma mark - Timer
- (void)startTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(repeatsScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _isAnimating = YES;
}
- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Callbacks
- (void)action_imgTap {
    
    if (self.tapImgBlock) {
        self.tapImgBlock(_currentImgIndex);
    }
    if (_isFullScreen) {
        [self cancelFullScreen];
    }
}

- (void)repeatsScroll {
    
    CGFloat currentOffset = self.scrollView.contentOffset.x;
    [self.scrollView setContentOffset:CGPointMake(currentOffset + _oneSelfWidth, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.imageArray.count > 1) {
        [self startTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = 0;
    if (!_isFullScreen) {
        if (self.isCircle) {
            currentPage = fabs(round((scrollView.contentOffset.x - _oneSelfWidth) / _oneSelfWidth));
        } else {
            currentPage = fabs(round(scrollView.contentOffset.x - _oneSelfWidth));
        }
    } else {
        if (self.isCircle) {
            currentPage = fabs(round((scrollView.contentOffset.x - SCREEN_WIDTH) / SCREEN_WIDTH));
        } else {
            currentPage = fabs(round(scrollView.contentOffset.x / SCREEN_WIDTH));
        }
    }
    self.pageControl.currentPage = currentPage;
    _currentImgIndex = currentPage;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX > _oneSelfWidth * (self.imageArray.count - 2) && self.isCircle) {
        [scrollView setContentOffset:CGPointMake(_oneSelfWidth, 0) animated:NO];
    }
    if (offsetX < _oneSelfWidth && self.isCircle) {
        [scrollView setContentOffset:CGPointMake(_oneSelfWidth * (self.imageArray.count - 2), 0) animated:NO];
    }
}
/** 重置scrollView */
- (void)resetScrollView {
    
    [self.imageArray removeAllObjects];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self stopTimer];
}

#pragma mark - Setter
- (void)setImgArray:(NSArray<UIImage *> *)imgArray {
    
    _imgArray = imgArray;
    [self resetScrollView];
    [self setupSubViewsWithImgArray:imgArray];
}

- (void)setImgURLArr:(NSArray<NSString *> *)imgURLArr {
    
    _imgURLArr = imgURLArr;
    [self resetScrollView];
    [self setupSubViewsWithImgNameUrlArray:imgURLArr];
}

- (void)setImgNameArray:(NSArray<NSString *> *)imgNameArray {
    
    _imgNameArray = imgNameArray;
    [self resetScrollView];
    [self setupSubViewsWithImgNameUrlArray:imgNameArray];
}

- (void)setCurrentIndicatorColor:(UIColor *)currentIndicatorColor {
    
    _currentIndicatorColor = currentIndicatorColor;
    self.pageControl.currentPageIndicatorTintColor = _currentIndicatorColor;
}

- (void)setOtherIndicatorColor:(UIColor *)otherIndicatorColor {
    
    _otherIndicatorColor = otherIndicatorColor;
    self.pageControl.pageIndicatorTintColor = _otherIndicatorColor;
}

- (void)setIndicatorFrame:(CGRect)indicatorFrame {
    
    _indicatorFrame = indicatorFrame;
    self.pageControl.frame = indicatorFrame;
}

#pragma mark - Getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounds = CGRectMake(0, 0, _oneSelfWidth, _oneSelfHeight);
        _scrollView.center = self.center;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        [self addSubview:_scrollView];
        [self addSubview:self.pageControl];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.bounds = CGRectMake(0, 0, _oneSelfWidth, 30);
        _pageControl.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds) - 20);
        _pageControl.numberOfPages = _imageCount - 2;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (NSMutableArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
}


















@end

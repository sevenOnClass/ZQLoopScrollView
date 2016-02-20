//
//  ZQLoopScrollView.m
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/20.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ZQLoopScrollView.h"

NSString *const kCellIdentifier = @"ReuseCellIdentifier";

/**
 * CollectionView for ad.
 */
@interface ZQCollectionCell : UICollectionViewCell

@property(nonatomic, strong) ZQLoadImageView *imageView;
@property(nonatomic, strong) UILabel         *titleLabel;
@property(nonatomic, assign) BOOL            isDragging;

@end

@implementation ZQCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[ZQLoadImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.titleLabel.hidden = YES;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(0, self.zq_height - 30, self.zq_width, 30);
    self.titleLabel.hidden = self.titleLabel.text.length > 0 ? NO : YES;
}
@end


@interface ZQLoopScrollView() <UICollectionViewDelegate, UICollectionViewDataSource> {
    ZQPageControl *_pageControl;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalPageCount;
// Record the previous page index, for we need to update to another page when
// it is clicked at some point.
@property (nonatomic, assign) NSInteger previousPageIndex;

@end

@implementation ZQLoopScrollView

+ (instancetype)loopScrollViewWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls {
    return [self loopScrollViewWithFrame:frame
                               imageUrls:imageUrls
                            timeInterval:5.0
                               didSelect:nil
                               didScroll:nil];
}
+ (instancetype)loopScrollViewWithFrame:(CGRect)frame
              imageUrls:(NSArray *)imageUrls
           timeInterval:(NSTimeInterval)timeInterval
              didSelect:(ZQLoopScrollViewDidSelectItemBlock)didSelect
              didScroll:(ZQLoopScrollViewDidScrollBlock)didScroll {
    ZQLoopScrollView *loopView = [[ZQLoopScrollView alloc] initWithFrame:frame];
    loopView.imageUrls = imageUrls;
    loopView.timeInterval = timeInterval;
    loopView.didScrollBlock = didScroll;
    loopView.didSelectItemBlock = didSelect;
    
    return loopView;
}

- (void)startTimer {
    if (self.timer) {
        [self.timer performSelector:@selector(setFireDate:)
                         withObject:[NSDate distantPast]
                         afterDelay:self.timeInterval];
    }
}

- (void)pauseTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)setPageControlTintColor:(UIColor *)color {
    if (self.pageControl) {
        self.pageControl.pageIndicatorTintColor = color;
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)color{
    if (self.pageControl) {
        self.pageControl.currentPageIndicatorTintColor = color;
    }
}
- (ZQPageControl *)pageControl {
    return _pageControl;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.layout.itemSize = frame.size;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.timeInterval = 5.0;
        self.alignment = kPageControlAlignCenter;
        [self configCollectionView];
    }
    return self;
}

- (void)removeFromSuperview {
    [self.timer invalidate];
    self.timer = nil;
    
    [super removeFromSuperview];
}

- (void)configCollectionView {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout .itemSize = self.bounds.size;
    self.layout .minimumLineSpacing = 0;
    self.layout .scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame
                                             collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView  registerClass:[ZQCollectionCell class]
             forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
}

- (void)setPageControlEnabled:(BOOL)pageControlEnabled {
    if (_pageControlEnabled != pageControlEnabled) {
        _pageControlEnabled = pageControlEnabled;
        
        if (_pageControlEnabled) {
            
            __weak __typeof(self) weakSelf = self;
            self.pageControl.valueChangedBlock = ^(NSInteger clickedAtIndex) {
                NSInteger curIndex = (weakSelf.collectionView.contentOffset.x
                                      + weakSelf.layout.itemSize.width * 0.5) / weakSelf.layout.itemSize.width;
                NSInteger toIndex = curIndex + (clickedAtIndex > weakSelf.previousPageIndex ? clickedAtIndex : -clickedAtIndex);
                [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]
                                                atScrollPosition:UICollectionViewScrollPositionNone
                                                        animated:YES];
                
            };
        } else {
            self.pageControl.valueChangedBlock = nil;
        }
    }
}

- (void)configPageControl {
    if (self.pageControl == nil) {
        _pageControl = [[ZQPageControl alloc] init];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];
        self.pageControlEnabled = YES;
    }
    [self bringSubviewToFront:self.pageControl];
    self.pageControl.numberOfPages = self.imageUrls.count;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageUrls.count];
    self.pageControl.zq_size = size;
    
    if (self.alignment == kPageControlAlignCenter) {
        self.pageControl.zq_originX = (self.zq_width - self.pageControl.zq_width) / 2.0;
    } else if (self.alignment == kPageControlAlignRight) {
        self.pageControl.zq_rightX = self.zq_width - 10;
    }
    self.pageControl.zq_originY = self.zq_height - self.pageControl.zq_height + 5;
}


- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    
    [self configTimer];
}

- (void)configTimer {
    if (self.imageUrls.count <= 1) {
        return;
    }
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval
                                                  target:self
                                                selector:@selector(autoScroll)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll {
    NSInteger curIndex = (self.collectionView.contentOffset.x + self.layout.itemSize.width * 0.5) / self.layout.itemSize.width;
    NSInteger toIndex = curIndex + 1;
    
    NSIndexPath *indexPath = nil;
    if (toIndex == self.totalPageCount) {
        toIndex = self.totalPageCount * 0.5;
        
        // scroll to the middle without animation, and scroll to middle with animation, so that it scrolls
        // more smoothly.
        indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
    } else {
        indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
}

- (void)setImageUrls:(NSArray *)imageUrls {
    if (![imageUrls isKindOfClass:[NSArray class]]) {
        return;
    }
    
    if (imageUrls == nil || imageUrls.count == 0) {
        self.collectionView.scrollEnabled = NO;
        [self pauseTimer];
        self.totalPageCount = 0;
        [self.collectionView reloadData];
        return;
    }
    
    if (_imageUrls != imageUrls) {
        _imageUrls = imageUrls;
        
        if (imageUrls.count > 1) {
            self.totalPageCount = imageUrls.count * 50;
            [self configTimer];
            [self configPageControl];
            self.collectionView.scrollEnabled = YES;
        } else {
            // If there is only one page, stop the timer and make scroll enabled to be NO.
            [self pauseTimer];
            
            self.totalPageCount = 1;
            [self configPageControl];
            self.collectionView.scrollEnabled = NO;
        }
        [self.collectionView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.totalPageCount == 0) {
        return;
    }
    
    self.collectionView.frame = self.bounds;
    if (self.collectionView.contentOffset.x == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.totalPageCount * 0.5
                                                     inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
    }
    
    [self configPageControl];
}

- (void)setAlignment:(ZQPageControlAlignment)alignment {
    if (_alignment != alignment) {
        _alignment = alignment;
        
        [self configPageControl];
        [self.collectionView reloadData];
    }
}

- (void)dealloc {
    NSLog(@"zqloopscrollview dealloc");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.totalPageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ZQCollectionCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                forIndexPath:indexPath];

    //先取消之前的请求
    ZQLoadImageView *preImageView = cell.imageView;
    if ([preImageView isKindOfClass:[ZQLoadImageView class]]) {
        [preImageView cancelRequest];
    }
    
    NSInteger itemIndex = indexPath.item % self.imageUrls.count;
    if (itemIndex < self.imageUrls.count) {
        NSString *urlString = self.imageUrls[itemIndex];
        if ([urlString isKindOfClass:[UIImage class]]) {
            cell.imageView.image = (UIImage *)urlString;
        } else if ([urlString hasPrefix:@"http://"]
                   || [urlString hasPrefix:@"https://"]
                   || [urlString rangeOfString:@"/"].location != NSNotFound) {
            [cell.imageView setImageWithURLString:urlString placeholder:self.placeholder];
        } else {
            cell.imageView.image = [UIImage imageNamed:urlString];
        }
    }
    
    if (self.alignment == kPageControlAlignRight && itemIndex < self.adTitles.count) {
        cell.titleLabel.text = [NSString stringWithFormat:@"   %@", self.adTitles[itemIndex]];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.totalPageCount == 0) {
        return;
    }
    if (self.didSelectItemBlock) {
        ZQCollectionCell *cell = (ZQCollectionCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
        self.didSelectItemBlock(indexPath.item % self.imageUrls.count, cell.imageView);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.totalPageCount == 0) {
        return;
    }
    
    int itemIndex = (scrollView.contentOffset.x +
                     self.collectionView.zq_width * 0.5) / self.collectionView.zq_width;
    itemIndex = itemIndex % self.imageUrls.count;
    _pageControl.currentPage = itemIndex;
    
    // record
    self.previousPageIndex = itemIndex;
    
    CGFloat x = scrollView.contentOffset.x - self.collectionView.zq_width;
    NSUInteger index = fabs(x) / self.collectionView.zq_width;
    CGFloat fIndex = fabs(x) / self.collectionView.zq_width;
    
    if (self.didScrollBlock && fabs(fIndex - (CGFloat)index) <= 0.00001) {
        ZQCollectionCell *cell = (ZQCollectionCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:0]];
        self.didScrollBlock(itemIndex, cell.imageView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self configTimer];
}
@end

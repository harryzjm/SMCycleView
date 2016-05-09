//
//  SMCycleView.m
//  SMCycleView
//
//  Created by Magic on 23/2/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

#import "SMCycleView.h"
#import <Masonry/Masonry.h>
#import "SMCycleCell.h"

static NSString * const cellIdentifier = @"SMCycleViewCell";
static NSInteger expandMul = 9;

@interface SMCycleView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UICollectionView *collectionV;

@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, assign, readonly) NSInteger startIndex;
@property (nonatomic, assign, readonly) NSInteger endIndex;

@end

@implementation SMCycleView

-(instancetype)init
{
    if (self = [super init]) {
        [self makeConstraints];
    }
    return self;
}

+ (instancetype)cycleViewWithImageGroup:(NSArray *)group
{
    SMCycleView *v = [self new];
    v.imageGroup = group;
    return v;
}

-(void)makeConstraints
{
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.width.equalTo(self);
        make.height.equalTo(@15);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.collectionV.bounds.size;
    
    [self.collectionV reloadItemsAtIndexPaths:self.collectionV.indexPathsForVisibleItems];
    [self fix];
}

#pragma mark - UI
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.estimatedItemSize = self.bounds.size;
        _flowLayout = flowLayout;
        
        UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionV.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        collectionV.pagingEnabled = YES;
        collectionV.showsHorizontalScrollIndicator = NO;
        collectionV.showsVerticalScrollIndicator = NO;
        [collectionV registerClass:[SMCycleCell class] forCellWithReuseIdentifier:cellIdentifier];
        collectionV.dataSource = self;
        collectionV.delegate = self;
        
        [self addSubview:collectionV];
        _collectionV = collectionV;
    }
    return _collectionV;
}

-(UIControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.userInteractionEnabled = NO;
        
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - Action

-(NSInteger)currentIndex {
    return self.collectionV.contentOffset.x / self.flowLayout.itemSize.width;
}

-(NSInteger)startIndex {
    return self.imageGroup.count * (expandMul/2);
}

-(NSInteger)endIndex {
    return self.startIndex + self.imageGroup.count;
}

-(void)scrollTo:(NSInteger)index {
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                             atScrollPosition:UICollectionViewScrollPositionNone
                                     animated:NO];
}

-(void)fix {
    if (self.currentIndex < self.startIndex || self.currentIndex > self.endIndex) {
        [self scrollTo:self.startIndex + self.currentIndex % self.imageGroup.count];
    }
}

- (void)setImageGroup:(NSArray *)imageGroup
{
    _imageGroup = imageGroup;
    
    self.pageControl.numberOfPages = imageGroup.count;
    self.collectionV.scrollEnabled = imageGroup.count > 1;
    [self.collectionV reloadData];
    
    [self fix];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageGroup.count * expandMul;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = self.imageGroup[ indexPath.item % self.imageGroup.count ];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectItemAtIndex:)]) {
        [self.delegate cycleView:self didSelectItemAtIndex:indexPath.item % self.imageGroup.count];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self fix];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger itemIndex = scrollView.contentOffset.x / self.collectionV.bounds.size.width + 0.5;
    self.pageControl.currentPage = itemIndex % self.imageGroup.count;
}


@end

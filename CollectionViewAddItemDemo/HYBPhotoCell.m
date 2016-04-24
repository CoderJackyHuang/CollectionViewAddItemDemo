//
//  HYBPhotoCell.m
//  CollectionViewAddItemDemo
//
//  Created by huangyibiao on 16/4/24.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBPhotoCell.h"
#import "HYBPhotoItemModel.h"
#import "HYBPhotoItemCell.h"

static NSString *kCellIdentifier = @"PhotoCellIdentifier";

@interface HYBPhotoCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HYBPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.selected = NO;
    
   CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, w - 20, 30)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = @"任务分配给";
    [self.contentView addSubview:self.titleLabel];
    
    CGRect rect = CGRectMake(0, self.titleLabel.frame.size.height, w, kPhotoItemHeight + 20);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w / 5.0 - 5, kPhotoItemHeight + 20);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 1;
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[HYBPhotoItemCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.frame.size.height + self.collectionView.frame.origin.y + 9, frame.size.width, 1.0)];
    [self.contentView addSubview:lineView];
    // 自行修改颜色
    lineView.backgroundColor = [UIColor lightGrayColor];
    self.lineView = lineView;
  }
  
  return self;
}

- (void)updateDataSoucesCount:(NSUInteger)count {
  CGRect frame = self.collectionView.frame;
  frame.size.height = (count / 5 + 1) * (kPhotoItemHeight + 20);
  self.collectionView.frame = frame;
  
  self.lineView.frame = CGRectMake(0, self.collectionView.frame.size.height + self.collectionView.frame.origin.y + 9, frame.size.width, 1.0);
  [self.collectionView reloadData];
}

- (void)setDataSources:(NSArray *)dataSources {
  if (_dataSources != dataSources) {
    _dataSources = dataSources;
    
    [self updateDataSoucesCount:dataSources.count];
  } else if (_dataSources == dataSources && dataSources != nil) {
    [self updateDataSoucesCount:dataSources.count];
  }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSources.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBPhotoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                 forIndexPath:indexPath];
  
  if (indexPath.item < self.dataSources.count) {
    HYBPhotoItemModel *model = self.dataSources[indexPath.item];
    cell.model = model;
  } else if (indexPath.item == self.dataSources.count) { // 默认的+
    HYBPhotoItemModel *model = [[HYBPhotoItemModel alloc] init];
    model.name = @"添加";
    model.photo = [UIImage imageNamed:@"add"];
    cell.model = model;
  }
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == self.dataSources.count) {
    if (self.addPhotoBlock) {
      self.addPhotoBlock();
    }
  } else {
    if (self.didSelectedBlock) {
      HYBPhotoItemModel *model = self.dataSources[indexPath.item];
      self.didSelectedBlock(model);
    }
  }
}
@end

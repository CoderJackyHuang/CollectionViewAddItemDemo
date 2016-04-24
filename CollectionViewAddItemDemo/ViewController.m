//
//  ViewController.m
//  CollectionViewAddItemDemo
//
//  Created by huangyibiao on 16/4/24.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBPhotoItemCell.h"
#import "HYBPhotoItemModel.h"
#import "HYBPhotoCell.h"


static NSString *kCellIdentifier = @"HYBPhotoCell";

@interface ViewController () <UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
// 数组中每个元素也是一个数组，每个元素数组里都是HYBPhotoItemModel对象
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(onAddClicked)];
  
  [self configUI];
}

- (void)configUI {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  [self.collectionView registerClass:[HYBPhotoCell class]
          forCellWithReuseIdentifier:kCellIdentifier];
  [self.view addSubview:self.collectionView];
  self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)onAddClicked {
  NSMutableArray *itemArray = [[NSMutableArray alloc] init];
  [self.dataSources addObject:itemArray];
  
  [self.collectionView reloadData];
}

- (NSMutableArray *)dataSources {
  if (_dataSources == nil) {
    _dataSources = [[NSMutableArray alloc] init];
    
    // 默认初始有一个空的cell
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    [_dataSources addObject:itemArray];
  }
  
  return _dataSources;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                 forIndexPath:indexPath];
  
  NSMutableArray *itemArray = self.dataSources[indexPath.item];
  cell.dataSources = itemArray;
  
  // 点击添加时的回调
  cell.addPhotoBlock = ^() {
    // 调用添加用户
    // 这里直接就添加数据来测试
    HYBPhotoItemModel *model1 = [[HYBPhotoItemModel alloc] init];
    model1.name = @"测试1";
    model1.photo = [UIImage imageNamed:@"img1.jpeg"];
    
    HYBPhotoItemModel *model2 = [[HYBPhotoItemModel alloc] init];
    model2.name = @"测试2";
    model2.photo = [UIImage imageNamed:@"img2.jpeg"];
    
    [itemArray addObject:model1];
    [itemArray addObject:model2];
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
  };
  
  // 点击某一个头像时的回调
  cell.didSelectedBlock = ^(HYBPhotoItemModel *model) {
    NSLog(@"点击头像，用户名叫：%@", model.name);
  };
  
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger count = [self.dataSources[indexPath.item] count];
CGFloat heiht = (count / 5 + 1) * (kPhotoItemHeight + 20);
  return CGSizeMake(self.view.frame.size.width, 50 + heiht);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
}

@end

//
//  HYBPhotoCell.h
//  CollectionViewAddItemDemo
//
//  Created by huangyibiao on 16/4/24.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBPhotoItemModel.h"

#define kPhotoItemHeight 60

typedef void(^HYBPhotoAddBlock)(void);
typedef void(^HYBPhotoDidSelectedBlock)(HYBPhotoItemModel *photoItemModel);

@interface HYBPhotoCell : UICollectionViewCell

// 每个元素是HYBPhotoItemModel类型
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, copy) HYBPhotoAddBlock addPhotoBlock;
@property (nonatomic, copy) HYBPhotoDidSelectedBlock didSelectedBlock;

@end

//
//  HomeViewController.h
//  InfiniteHelp
//
//  Created by sands on 16/7/19.
//  Copyright © 2016年 sands. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface HomeViewController : UIViewController<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

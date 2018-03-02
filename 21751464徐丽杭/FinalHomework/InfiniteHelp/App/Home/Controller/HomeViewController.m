//
//  HomeViewController.m
//  InfiniteHelp
//
//  Created by sands on 16/7/19.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "HomeViewController.h"
#import "ImageModel.h"
#import "HomeDemandCell.h"
#import "HomeTitleView.h"
#import "ProjectDetailViewController.h"
#import "LoginViewController.h"

@interface HomeViewController (){
    NSMutableArray* _ImageData;
    int _page;
}
@property (nonatomic,strong)UIScrollView * scrollV;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AddNavigationTitleView];
    _page = 10;
    _ImageData = [[NSMutableArray alloc]initWithCapacity:0];
    [self.view addSubview:self.collectionView];
    [self requestWithGetHomeListData];
}

#pragma mark 创建collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        //(下,右,)
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[HomeDemandCell class] forCellWithReuseIdentifier:@"WaterfallCell"];
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _ImageData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"HomeDemandCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"WaterfallCell"];
    ImageModel * model = _ImageData[indexPath.row];
    HomeDemandCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterfallCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[ NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"rc"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"index section = %ld index row = %ld",indexPath.section,indexPath.row);
    ProjectDetailViewController* ProjectDetailViewC = [[ProjectDetailViewController alloc]initWithNibName:@"ProjectDetailViewController" bundle:nil];
    ProjectDetailViewC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ProjectDetailViewC animated:YES];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageModel * model = _ImageData[indexPath.row];
    float height,width;
    width=(([UIScreen mainScreen].bounds.size.width)-30)/2;
    height=width*[model.height floatValue]/[model.width floatValue];
    return CGSizeMake(width, height+115);
}


#pragma mark 请求首页数据
- (void)requestWithGetHomeListData{
    NSLog(@"requestWithGetHomeListData");
    [[AFNetConnect connect] AFNetGet:[NSString stringWithFormat:@"%d",_page] params:nil result:^(bool success, id result) {
        if (success == 1) {
            NSArray* arr = result[@"data"];
            for (int i = 0; i<arr.count; i++) {
                ImageModel * model = [[ImageModel alloc]initWithDic:arr[i]];
                [_ImageData addObject:model];
            }
        }
        NSLog(@"reloadData");
        NSLog(@"model count = %ld",_ImageData.count);
        [self.collectionView reloadData];
    }];
}

#pragma mark 导航栏内容
- (void)AddNavigationTitleView {
    HomeTitleView* titleView = [[[NSBundle mainBundle] loadNibNamed:@"HomeTitleView" owner:self options:nil]lastObject];
    titleView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    [titleView.ClassifyBtn addTarget:self action:@selector(classifyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleView;
}

- (void)classifyBtnAction {
    NSLog(@"classifyBtnAction");
    LoginViewController* Login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:Login animated:true completion:nil];
}
@end

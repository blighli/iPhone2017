//
//  HMSSubTagCell.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSSubTagCell.h"
#import "HMSSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface HMSSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation HMSSubTagCell
/*
 头像变成圆角 1.设置头像圆角 2.裁剪图片（生成新的图片->图片上下文才能够生成新图）
 */
- (void)setItem:(HMSSubTagItem *)item {
    _item = item;
    //设置内容
    _nameView.text = item.theme_name;
    
    [self resolveNum];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.设置裁剪区域
        [path addClip];
        //4.画图片
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭上下文
        UIGraphicsEndImageContext();
        _iconView.image = image;
    }];
}
//处理订阅数字
- (void)resolveNum {
    // 判断有没有大于10000
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    NSInteger num = _item.sub_number.integerValue;
    if(num > 10000) {
        CGFloat numF =  num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
}
//从xib加载就会调用
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置头像圆角 iOS9苹果修复卡顿问题
//    _iconView.layer.cornerRadius = 30;
//    _iconView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

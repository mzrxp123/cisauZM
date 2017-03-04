//
//  ZMHomePageViewCell.m
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/24.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import "ZMHomePageViewCell.h"
#import "ZMHomePageProductModel.h"
#import "Contant.h"
#define CNYLOGO @"¥ "
@interface ZMHomePageViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *commodityImageView;
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingCartImageView;
@end
@implementation ZMHomePageViewCell

- (void)setModel:(ZMHomePageProductModel *)model {
    _model = model;
    if (model.thumbnailUrl1) {
        NSString * imgUrl = [NSString stringWithFormat:@"%@%@",ZM_MAIN_URL,model.thumbnailUrl1];
        [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"aviary_iap_workspace_shadow_top"]];
    }
    self.commodityNameLabel.text = model.productName;
    self.commodityPriceLabel.text = [NSString stringWithFormat:@"%@%.2f",CNYLOGO,model.lowestSalePrice];
    
//    self.commodityPriceLabel.font = [UIFont systemFontOfSize:17*MZR_SCREEN_WIDTH/414];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

//
//  PullDownCell.m
//  E_User
//
//  Created by YH_O on 2017/5/15.
//  Copyright © 2017年 OYH. All rights reserved.
//

#import "PullDownCell.h"

@interface PullDownCell ()

@property (weak, nonatomic) IBOutlet UIButton *textBtn;

@end

@implementation PullDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutCustomSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.textBtn.selected = selected;
}

- (void)layoutCustomSubviews {
    
    self.selectedBackgroundView = [UIView new];
}

#pragma mark - Setter
- (void)setTitle:(NSString *)title {
    
    _title = title;
    [self.textBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    [super setFrame:frame];
}

















@end

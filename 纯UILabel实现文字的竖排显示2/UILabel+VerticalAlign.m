//
//  UILabel+VerticalAlign.m
//  纯UILabel实现文字的竖排显示2
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 lu. All rights reserved.
//

#import "UILabel+VerticalAlign.h"

// -- file: UILabel+VerticalAlign.m
@implementation UILabel (VerticalAlign)

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    NSString * font = 
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}
@end

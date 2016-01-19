//
//  ViewController.m
//  纯UILabel实现文字的竖排显示2
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 lu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * string = @"Hey原声带91X";
    CGRect frame = self.view.frame;
    UIFont *font = [UIFont systemFontOfSize:16];
    float height = 40;
    NSArray * stringItemArray = [self splitTitle:string];
    
    for (StringItem *item in stringItemArray) {
        if (item.isChinese) {
            
            
            CGSize size = [string boundingRectWithSize:CGSizeMake(16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - size.width) / 2, height, size.width, size.height - 16)];
            NSLog(@"%@", NSStringFromCGRect(CGRectMake((frame.size.width - size.width)/2, height, size.width+16, size.height)));
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = font;
            label.backgroundColor = [UIColor clearColor];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.text = item.content;
            
            label.numberOfLines = 0;
            
            [self.view addSubview:label];
            height = height + label.frame.size.height;
        } else {
            
            CGSize size = [string boundingRectWithSize:CGSizeMake(16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - size.width) / 2, height, size.width + 10, size.height)];
            NSLog(@"%@", NSStringFromCGRect(CGRectMake((frame.size.width - size.width)/2, height, size.width+16, size.height)));
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.font = font;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.text = item.content;
            
            label.numberOfLines = 1;
            
            label.transform = CGAffineTransformMakeRotation(M_PI_2);
            
            label.frame = CGRectMake((frame.size.width - label.frame.size.width) / 2, height, label.frame.size.width, label.frame.size.height + 16);
            [self.view addSubview:label];
            height = height + label.frame.size.height;
        }
    }
}


- (BOOL)isChinese:(NSString *)str index:(int)index {
    
    NSRange range = NSMakeRange(index, 1);
    NSString * subString = [str substringWithRange:range];
    const char * cString = [subString UTF8String];
    if (strlen(cString) == 3) {
        return YES;
    }
    else {
        return NO;
    }
}


/**
 *  拆分标题中的中文与非中文
 */
- (NSMutableArray *)splitTitle:(NSString *)title
{
    NSMutableArray *stringItemArray = [[NSMutableArray alloc] init];
    int type = 0;
    if ([self isChinese:title index:0]) {
        type = 1;
    } else {
        type = 0;
    }
    int fromIndex = 0;
    int toIndex = 0;
    for (int i = 1; i<title.length; i++) {
        if (type == 1) {
            if ([self isChinese:title index:i]) {
                if (i == title.length - 1) {
                    StringItem *item = [[StringItem alloc] init];
                    item.isChinese = [self isChinese:title index:i];
                    item.content = [title substringWithRange:NSMakeRange(fromIndex, title.length - fromIndex)];
                    [stringItemArray addObject:item];
                }
                toIndex = i;
            } else {
                type = 0;
                StringItem *item = [[StringItem alloc] init];
                item.isChinese = YES;
                item.content = [title substringWithRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
                [stringItemArray addObject:item];
                
                fromIndex = i;
                toIndex = i;
                if (i == title.length - 1) {
                    StringItem *item = [[StringItem alloc] init];
                    item.isChinese = [self isChinese:title index:i];
                    item.content = [title substringWithRange:NSMakeRange(fromIndex, title.length - fromIndex)];
                    [stringItemArray addObject:item];
                    
                }
            }
        } else {
            if (![self isChinese:title index:i]) {
                if (i == title.length - 1) {
                    StringItem *item = [[StringItem alloc] init];
                    item.isChinese = [self isChinese:title index:i];
                    item.content = [title substringWithRange:NSMakeRange(fromIndex, title.length - fromIndex)];
                    [stringItemArray addObject:item];
                    
                }
                toIndex = i;
            } else {
                type = 1;
                StringItem *item = [[StringItem alloc] init];
                item.isChinese = NO;
                item.content = [title substringWithRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
                [stringItemArray addObject:item];
                
                fromIndex = i;
                toIndex = i;
                if (i == title.length - 1) {
                    StringItem *item = [[StringItem alloc] init];
                    item.isChinese = [self isChinese:title index:i];
                    item.content = [title substringWithRange:NSMakeRange(fromIndex, title.length - fromIndex)];
                    [stringItemArray addObject:item];
                }
            }
        }
    }
    return stringItemArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

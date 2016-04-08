//
//  VCMenuSelect.h
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BasicBlock)();
@interface VCMenuSelect : UIViewController
- (void)setCancleBarItemHandle:(BasicBlock)basicBlock;

@end

//
//  CELLSelect.h
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    CL_SeleType_Radio  = 0,
    
    CL_SeleType_CheckBoxes,

} CL_SeleType ;

@interface MCELLSelect : NSObject
@property (nonatomic,assign)CGFloat baseheight;
@property (nonatomic,strong)NSArray *arrLabel;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSMutableArray *selectArr;
@property (nonatomic,assign) CL_SeleType seleType;
@property (nonatomic,assign)CGFloat cellHeight;
@end

typedef void (^Block)(NSArray*arr );
@interface CELLSelect : UITableViewCell
@property (nonatomic,strong)MCELLSelect *data;

@property (nonatomic,strong) NSMutableArray *titleArray;//选中的label
@property (nonatomic,copy)Block block;
- (void)setSelctedBlock:(Block)block;
- (void)updateData;
- (void)onint;
@end

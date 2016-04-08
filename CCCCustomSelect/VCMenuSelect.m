//
//  VCMenuSelect.m
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import "VCMenuSelect.h"
#import "NSNotification+Extension.h"
#import "CELLSelect.h"
@interface VCMenuSelect ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) BasicBlock basicBlock;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitle;
@property (nonatomic, strong) NSMutableArray  *arritle;
@property (nonatomic,strong)NSMutableArray *storeArr;

@end

@implementation VCMenuSelect

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storeArr = [NSMutableArray array];
//    self.title = @"筛选";
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = cancelBarItem;
    
    
    UIBarButtonItem *SureBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureAction)];
    UIBarButtonItem *spaceBar = [self spacerWithSpace:0];
    self.navigationItem.rightBarButtonItems = @[spaceBar,SureBarItem];

        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-50)*.45, 0, 50, 40  )];
         l.text = @"筛选";
        [self.navigationController.navigationBar addSubview: l];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width-50, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CELLSelect class] forCellReuseIdentifier:@"CELLSelect"];
    // Do any additional setup after loading the view.
    [self buildData];
}
- (void)buildData{
    
    self.arritle = [NSMutableArray array];
    MCELLSelect *M = [[MCELLSelect alloc]init];
    M.arrLabel =@[@"病友",@"医院",@"诊所",@"医生",@"药房",@"公交",@"导航",@"记忆"];
    M.title = @"显示内容";
    M.seleType = CL_SeleType_CheckBoxes;
    [self.arritle addObject:M];
    M = [[MCELLSelect alloc]init];
    M.arrLabel =@[@"位置最近",@"ccc优先",@"男士优先",@"女士优先",@"老人优先"];
    M.title = @"排序方式";
    M.seleType = CL_SeleType_Radio;
    [self.arritle addObject:M];
    [self.tableView reloadData];
}

- (void)setCancleBarItemHandle:(BasicBlock)basicBlock{
    
    self.basicBlock = basicBlock;
    
}
-(void)sureAction{
    [self postNotification:@"CCC"];
    [self cancelAction];
    [self  postNotification:@"backData" withObject:self.storeArr];

}
- (void)cancelAction{
    if(self.basicBlock){
        self.basicBlock();
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arritle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CELLSelect *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLSelect"];
    
    if(!cell){
        
        cell = [[CELLSelect alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLSelect"];
        
    }
    MCELLSelect *M =self.arritle[indexPath.section];
    cell.data =  M;
    __weak typeof(cell) cellweak= cell;

    [cell setSelctedBlock:^(NSArray *arr) {
        [self.storeArr  addObjectsFromArray:arr];
        [cellweak.titleArray removeAllObjects];
    }];
    
    [cell onint];
    [cell updateData];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CELLSelect* cell = (CELLSelect*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        CGFloat rect = cell.data.cellHeight;
        return rect;

    }
    
    return 100;

    
    
}
- (UIBarButtonItem *)spacerWithSpace:(CGFloat)space
{
    UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBar.width = space;
   
    return spaceBar;
}
- (void)dealloc{

    [self unobserveAllNotifications];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

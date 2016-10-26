//
//  ViewController.m
//  TestNetWorking
//
//  Created by Ethank on 2016/10/25.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "BottomView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, BottomViewDelegate>
@property (nonatomic ,weak)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)BottomView *bottomView;
@end

@implementation ViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupViews];
    [self setupBottomViews];
}

- (void)setupNavigationItem {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.0f;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(tableView.superview);
        make.bottom.equalTo(tableView.superview).offset(49.0);
    }];
    self.tableView = tableView;
}

- (void)setupBottomViews {
    BottomView *bottomView = [[BottomView alloc] init];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bottomView.superview);
        make.height.mas_equalTo(49.0);
    }];
    bottomView.hidden = YES;
    self.bottomView = bottomView;
}

#pragma mark-Action

- (void)deleteItem:(id)sender {
    NSArray *selectedItems = self.tableView.indexPathsForSelectedRows;
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for (NSIndexPath *indexPath in selectedItems) {
        [set addIndex:indexPath.row];
    }
    
    [self.dataArray removeObjectsAtIndexes:set];
    [self.tableView deleteRowsAtIndexPaths:selectedItems withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)selectAllItem:(id)sender {
    NSLog(@"Selected All");
    NSArray *arr = [self.tableView indexPathsForRowsInRect:CGRectMake(0, 0, self.view.frame.size.width, self.tableView.contentSize.height)];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView selectRowAtIndexPath:obj animated:YES scrollPosition:UITableViewScrollPositionNone];
    }];
}

- (void)edit:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    self.navigationItem.rightBarButtonItem.title = self.tableView.editing ? @"cancel" : @"edit";
    self.bottomView.hidden = !self.tableView.editing;
    if (self.tableView.editing) {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_tableView.superview).offset(-49.0);
        }];
    } else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_tableView.superview);
        }];
    }
}

#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark-Edit

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark-UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete;
}


#pragma mark-BottomViewDelegate

- (void)clickSelectedAll {
    [self selectAllItem:nil];
}

- (void)clickDeleted {
    [self deleteItem:nil];
}

@end

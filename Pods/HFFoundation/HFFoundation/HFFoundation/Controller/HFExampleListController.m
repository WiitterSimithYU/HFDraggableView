//
//  HFExampleListController.m
//  HFFoundation
//
//  Created by Henry on 25/08/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

#import "HFExampleListController.h"

static NSString *const kCellIdentifier_HFExampleListController = @"HFExampleListControllerCellIdentifier";

@interface HFExampleItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *clsName;
+ (instancetype)itemWithControllerNamed:(NSString *)clsName title:(NSString *)title;
@end


@implementation HFExampleItem
+ (instancetype)itemWithControllerNamed:(NSString *)clsName title:(NSString *)title {
    HFExampleItem *item = [[self alloc] init];
    item.clsName = clsName;
    item.title = title;
    return item;
}
@end

#pragma mark-


@interface HFExampleListController ()
@property (nonatomic, copy) NSArray<HFExampleItem *> *exampleItems;
@end

@implementation HFExampleListController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if ([self conformsToProtocol:@protocol(HFExampleListProtocol)] &&
        [self respondsToSelector:@selector(exampleList)]) {
        self.child =  (id<HFExampleListProtocol>)self;
    } else {
        NSAssert(NO, @"子类必须遵守 HFExampleListProtol 协议并实现相应方法");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier_HFExampleListController];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HFExampleItem *item = self.exampleItems[indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier_HFExampleListController];
    if (indexPath.row%2 != 0) {
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    cell.textLabel.text = item.title;
    return cell;
}

#pragma mark- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HFExampleItem *item = self.exampleItems[indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(item.clsName) alloc] init];
    if (!vc) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"找不到对应示例" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    vc.navigationItem.title = item.title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark- accessor

- (NSArray<HFExampleItem *> *)exampleItems {
    if (_exampleItems == nil) {
        NSDictionary *examplesInfo = [(id<HFExampleListProtocol>)self exampleList];
        NSMutableArray *array  = [NSMutableArray arrayWithCapacity:examplesInfo.count];
        [examplesInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [array insertObject:[HFExampleItem itemWithControllerNamed:obj title:key] atIndex:0];
        }];
        _exampleItems = [array copy];
    }
    return _exampleItems;
}

@end

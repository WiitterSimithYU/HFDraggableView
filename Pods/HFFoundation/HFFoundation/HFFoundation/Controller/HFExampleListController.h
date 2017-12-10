//
//  HFExampleListController.h
//  HFFoundation
//
//  Created by Henry on 25/08/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 子类化 HFExampleListController 必须遵守的`<HFExampleListProtocol>`协议并实现相应方法
 */
@protocol HFExampleListProtocol <NSObject>
@required

/**
 示例列表

 @return key-value 格式为: `示例标题: 相应 controller 类名`
 */
- (NSDictionary *)exampleList;
@end



/**
 使用方法
 1. 继承 HFExampleListController 
 2. 遵守 <HFExampleListProtocol> 协议并实现
 */
@interface HFExampleListController : UITableViewController
@property (nonatomic, weak) id<HFExampleListProtocol> child; ///< <#desc#>
@end

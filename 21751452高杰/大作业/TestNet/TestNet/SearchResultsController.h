//
//  SearchResultsController.h
//  demo_05
//
//  Created by Yif-JJ on 2017/10/11.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsController : UITableViewController
<UISearchResultsUpdating>

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys;

@end

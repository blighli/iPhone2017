//
//  ProfileScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "ProfileScreen.h"
#import "SearchResultsController.h"
static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface ProfileScreen ()
@property (copy,nonatomic)NSDictionary *names;
@property (copy,nonatomic)NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)UISearchController *searchController;
@end

@implementation ProfileScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人";
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:SectionsTableIdentifier];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames"
                                                     ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:
                 @selector(compare:)];
    
    SearchResultsController *resultsController = [[SearchResultsController alloc] initWithNames:self.names keys:self.keys];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    
    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.scopeButtonTitles = @[@"All", @"Short", @"Long"];
    searchBar.placeholder = @"Enter a search term";
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    self.searchController.searchResultsUpdater = resultsController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return self.keys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier
                                    forIndexPath:indexPath];
    
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    
    cell.textLabel.text = nameSection[indexPath.row];
    return cell;
}
//添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
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

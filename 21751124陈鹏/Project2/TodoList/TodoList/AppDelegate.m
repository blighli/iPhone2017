//
//  AppDelegate.m
//  TodoList
//
//  Created by Mr.Right on 2017/10/15.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import "AppDelegate.h"

NSString *TodoListPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
    return [pathList[0] stringByAppendingPathComponent:@"todoList.td"];
}

@interface AppDelegate ()
@property UITableView *taskTable;
@property UITextField *taskField;
@property UIButton *insertButton;
@property NSMutableArray *tasks;

- (void)addTask:(id)sender;
//- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *vc = [[UIViewController alloc] init];
    self.window.rootViewController = vc;

    int winFrameWidth = self.window.frame.size.width;
    int winFrameHeight = self.window.frame.size.height;
    CGRect tableFrame = CGRectMake(20, 80, winFrameWidth - 40,winFrameHeight - 100);
    int fieldFrameWidth = winFrameWidth * 4 / 6;
    CGRect fieldFrame = CGRectMake(20, 40, fieldFrameWidth, 30);
    int buttonFrameWidth = winFrameWidth * 1 / 6;
    CGRect buttonFrame = CGRectMake(20 + fieldFrameWidth, 40, buttonFrameWidth, 30);

    
    self.taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.taskTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.taskTable setSeparatorColor:[UIColor whiteColor]];
    self.taskTable.dataSource = self;
    self.taskTable.delegate = self;
    [self.taskTable registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    
    

    self.taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    self.taskField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskField.placeholder = @"Type a task, tap Insert";

    self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.insertButton.frame = buttonFrame;
    [self.insertButton setTitle:@"Add"
                       forState:UIControlStateNormal];
    
    [self.insertButton addTarget:self
                          action:@selector(addTask:)
                forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:TodoListPath()];
    if (plist) {
        self.tasks = [plist mutableCopy];
    } else {
        self.tasks = [NSMutableArray array];
    }
    

    [vc.view addSubview:self.taskTable];
    [vc.view addSubview:self.taskField];
    [vc.view addSubview:self.insertButton];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.tasks writeToFile:TodoListPath() atomically:YES];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Button management
- (void)addTask:(id)sender{
    NSString *task = self.taskField.text;
    
    if([task isEqualToString:@""]){
        return;
    }
    
    [self.tasks addObject:task];
    [self.taskTable reloadData];
    self.taskField.text = @"";
    [self.taskField resignFirstResponder];
}

#pragma mark - Table view management
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    NSString *item = [self.tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    
    if (cell.gestureRecognizers.count ==0) {
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = 1; //seconds  设置响应时间
        lpgr.delegate = self;
        [cell addGestureRecognizer:lpgr];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer  //长按响应函数
{

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        UITableViewCell *cell = (UITableViewCell *)gestureRecognizer.view;

        [cell becomeFirstResponder];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除选择" message:nil preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.tasks removeObjectAtIndex:[[self.taskTable indexPathForCell:cell] row]];
            [self.taskTable reloadData];
            NSLog(@"%@", self.tasks);
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
       [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0){
//
//    }
//
//}

@end

//
//  MSAppDelegate.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSAppDelegate.h"
#import "CoreDataTableViewController.h"
#import "MSMailMan.h"


#define FIRSTIME_USER_KEY @"firstTime"

@interface MSAppDelegate ()
@property (nonatomic,strong,readwrite) UIManagedDocument *managedDocument;
@property (nonatomic,strong) MSMailMan *mailMan;
@end

@implementation MSAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    if ([self getUserDefaultData] == nil) {
        //first time
        
        
        [self setUserDefaultsData];
    }
    
    [self registerForLocalNotifications:application];

    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    [self customizeTabBarController:tabBarController.tabBar];
    [self prepareFirstControllerFrom:tabBarController];
    [self mailManStart];
    
    application.applicationIconBadgeNumber = 0;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self mailManStart];
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark - Private methods


-(void)mailManStart{
    [self.mailMan showAlertViewIfLettersArePrepared:self.managedDocument];
}

- (void)setUserDefaultsData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@1 forKey:FIRSTIME_USER_KEY];
    [defaults synchronize];
}

-(NSNumber*)getUserDefaultData{
    return [[NSUserDefaults standardUserDefaults] objectForKey:FIRSTIME_USER_KEY];
}


-(void)customizeTabBarController:(UITabBar*)tabBar{
#warning refactor magic numbers
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    tabBarItem1.title = NSLocalizedString(@"Pending_TableViewTitle", nil);
    tabBarItem2.title = NSLocalizedString(@"Read_TableViewTitle", nil);
    [tabBarItem1 setImage:[[UIImage imageNamed:@"SelectedItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UITabBar appearance] setTintColor:MAIN_COLOR];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -14)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:19.0]} forState:UIControlStateNormal];
    
}

-(void)prepareFirstControllerFrom:(UITabBarController*)tabBarController{
    for (UINavigationController *navController in tabBarController.viewControllers) {
        CoreDataTableViewController *topController = (CoreDataTableViewController*)navController.topViewController;
        topController.manageDocument = self.managedDocument;
    }
}

-(void)registerForLocalNotifications:(UIApplication*)application{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    // The following line must only run under iOS 8. This runtime check prevents
    // it from running if it doesn't exist (such as running under iOS 7 or earlier).
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
#endif
    
}

#pragma mark -
#pragma mark - Core Data stack

- (UIManagedDocument *)managedDocument {
    if (_managedDocument == nil) {
        NSURL *myModelURL = [[self getDocumentsDirectory] URLByAppendingPathComponent:@"Model.model"];
        _managedDocument = [[UIManagedDocument alloc] initWithFileURL:myModelURL];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[myModelURL path]]) {
            [_managedDocument openWithCompletionHandler:^(BOOL success) {
                if (!success) {
                    //ERROR
                    NSLog(@"Error al abrir el ManagedDocument");
                }
            }];
        } else {
            [_managedDocument saveToURL:myModelURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                if (!success) {
                    //ERROR
                    NSLog(@"Error al crear el ManagedDocument");
                }
            }];
        }
    }
    return _managedDocument;
}


-(NSURL*)getDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark - Getters & Setters

-(MSMailMan *)mailMan{
    if (!_mailMan) {
        _mailMan = [[MSMailMan alloc]init];
    }
    return _mailMan;
}

@end
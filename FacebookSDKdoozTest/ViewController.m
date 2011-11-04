//
//  ViewController.m
//  FacebookSDKdoozTest
//
//  Created by Stijn Willems on 04/11/11.
//  Copyright (c) 2011 dooZ. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize facebook =_facebook;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"[ViewController] beginning Facebook login");
    
    self.facebook = [[Facebook alloc] initWithAppId:@"272474129433721" andDelegate:self];
    //Check for previously saved information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] &&[defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    //Check for a valid session and if it is not valid call the authorize method which will both log the user in and prompt the user to authorize the app
    
    if (![self.facebook isSessionValid]) {
        NSLog(@"[ViewController] is authorizing via facebook");
        [self.facebook authorize:nil];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Facebook delegate methods

//Facebook PRE 4.2 support

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self.facebook handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self.facebook handleOpenURL:url];
}

//FBSessionDelegate implementation: Save user's credentials (accces token and corresponding expiration date)
-(void)fbDidLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.facebook accessToken] forKey:@"FBAccesTokenKey"];
    [defaults setObject:[self.facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

@end

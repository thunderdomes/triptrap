//
//  indexViewController.m
//  Tripify
//
//  Created by Arie on 7/3/13.
//  Copyright (c) 2013 vootobox. All rights reserved.
//

#import "indexViewController.h"

@interface indexViewController ()

@end

@implementation indexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title=@"Flights";
			[self fetchInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}
-(void)fetchInstance{
	NSString *url=@"http://www.wego.com/api/flights/startSearch.html?format=json&fromLocation=SIN&toLocation=BKK&tripType=roundTrip&cabinClass=Economy&inboundDate=2013-08-26&outboundDate=2013-08-23&numAdults=1&apiKey=c055c1b373c6d9d84c0c";
	
	NSURL *URL=[NSURL URLWithString:url];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	AFJSONRequestOperation *operation=[[AFJSONRequestOperation alloc] initWithRequest:request];
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
	
    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"response Object--->%@",responseObject);
		[self fetchDetails:[[responseObject objectForKey:@"request"]objectForKey:@"instanceId"]];
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
			
			//[spinner stopAnimating];
			//regional_radioList.hidden=YES;
		}
        NSLog(@"error: %@", [error description]);
		
	}];
	[operation start];
	
	

}
-(void)fetchDetails:(NSString*)instanceId{
	NSString *url=[NSString stringWithFormat:@"%@/pull.html?format=json&apiKey=%@&instanceId=%@&rand=1",flight_url,api_key,instanceId];
	
	NSURL *URL=[NSURL URLWithString:url];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	AFJSONRequestOperation *operation=[[AFJSONRequestOperation alloc] initWithRequest:request];
	//[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
	
    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"response Object--->%@",responseObject);
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
			//[spinner stopAnimating];
			//regional_radioList.hidden=YES;
		}
        NSLog(@"error: %@", [error description]);
		
	}];
	[operation start];
}
- (void)didReceiveMemoryWarning
{
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

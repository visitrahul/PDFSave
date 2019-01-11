//
//  ViewController.m
//  Demo7Jan
//
//  Created by Rahul Deshmukh on 07/01/19.
//  Copyright © 2019 Rahul Deshmukh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendRequest {
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"write a url here"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    // Add the proper header value here.
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    // Add the body parameters here. First is value & second is key.
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"TEST IOS", @"name",
                             @"IOS TYPE", @"typemap",
                             nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Get the data from data param
        // Check response.statusCode here if its 200.
        
        // Create a NSData parameter in viewDidLoad method above like if there is need to use it to any other place.
        // Else you can go with data variable of this method.
        /*
            dataObj = [[NSData alloc] init];
         
            asssign data to dataObj here in this method.
         */
        
        // Call save pdf from here loke
        [self savePDF:self.dataObj];
    }];
    
    [postDataTask resume];
}

- (void)savePDF:(NSData *)pdfContent
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask ,YES );
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:@"myPdf.pdf"];
    NSLog(@"%@",finalPath);
    NSURL *url = [NSURL fileURLWithPath:finalPath];
    [pdfContent writeToURL:url atomically:YES];
    
    // Grab this url in any variable & pass this url to react native class from call back method. There you can open the pdf from this url.
    //[webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end

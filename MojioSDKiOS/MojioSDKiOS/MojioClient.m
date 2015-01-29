//
//  MojioClient.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-22.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "MojioClient.h"
//#import "App.h"
#import <AFNetworking.h>
#import "JSONModel.h"
#import "AFURLResponseSerialization.h"

@interface MojioClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *baseApiUrl;

@end

@implementation MojioClient

-(id) init {
    self = [super init];
    if (self) {
        self.baseApiUrl = [NSString stringWithFormat:@"https://api.moj.io/v1/"];
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.moj.io/v1/"]];
    }
    return self;
}

+ (id) sharedInstance {
    static MojioClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme:(NSString *)urlScheme {
    self.appId = appId;
    self.secretKey = secretKey;
    self.redirectUrlScheme = urlScheme;
}

-(void) login {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Reuse stored token if it exists and not expired
    if ([defaults objectForKey:@"MojioAccessToken"] && [defaults doubleForKey:@"MojioTokenExpireTime"] > [NSDate date].timeIntervalSince1970) {
        self.authToken = [defaults objectForKey:@"MojioAccessToken"];
        [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io/OAuth2/authorize?response_type=token&client_id=%@&redirect_uri=%@", self.appId, self.redirectUrlScheme];
        
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)logout {
    [[self.manager requestSerializer] setValue:nil forHTTPHeaderField:@"MojioAPIToken"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"MojioAccessToken"];
    [defaults removeObjectForKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
}

- (void)handleOpenURL:(NSURL *)url {
    NSDictionary *params = [self parseQueryString:url.absoluteString];
    
    NSString *token = params[@"access_token"];
    NSInteger expires_in = [params[@"expires_in"] integerValue]; //expire time in minutes
    NSTimeInterval expireTime = [NSDate date].timeIntervalSince1970 + expires_in * 60;
    
    self.authToken = token;
    [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"MojioAccessToken"];
    [defaults setObject:@(expireTime) forKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSString *paramString = [[query componentsSeparatedByString:@"#"] lastObject];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [paramString componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] >= 2) {
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

-(void) getEntityWithPath:(NSString *)path withQueryOptions:(NSDictionary *)queryOptions success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    self.manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [self.manager GET:path parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        // if the response is a nsdata
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
            if (success != nil) {
                success(responseString);
            }
            return;
        }
        
        NSMutableArray *responseObjects = [NSMutableArray array];
        //TODO - check if response is of type array before adding it to the array
        
        for (NSDictionary *dict in [responseObject objectForKey:@"Data"]) {
            NSError *err;
            NSString *type = [dict objectForKey:@"Type"];
            id object = [[NSClassFromString(type) alloc] initWithDictionary:dict error:&err];
            [responseObjects addObject:object];
        }
        if (success != nil) {
            success(responseObjects);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure(error);
        }
    }];

}

- (void) updateEntityWithPath:(NSString *)path withContentBody:(NSString *)contentBody success:(void (^)(void))success failure:(void (^)(void))failure {
    
    NSData *data = [contentBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self.manager.baseURL.absoluteString stringByAppendingString:path];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPBody:data];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"PUT"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
        NSLog(@"%@", responseObject);
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    [operation start];
    
}

-(void) createEntityWithPath:(NSString *)path withContentBody:(NSString *)contentBody success:(void (^)(void))success failure:(void (^)(void))failure {
    NSData *data = [contentBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self.manager.baseURL.absoluteString stringByAppendingString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPBody:data];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
        NSLog(@"%@", responseObject);
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    [operation start];

}

-(void) deleteEntityWithPath:(NSString *)path success:(void (^)(void))success failure:(void (^)(void))failure {
    
    [self.manager DELETE:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

//-(void) deleteEntity:(NSString *)entity withEntityId : (NSString *)entityId withQueryOptions:(NSDictionary *)queryOptions withParams:(NSArray *)params success:(void (^)(id))success fail:(void (^)(NSError *))fail {
//    
//    NSString *request = [self request:params];
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",  entity, entityId, request];
//    
//    [self.manager DELETE:urlString parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }];
//    
//}

//-(NSString *) request : (NSArray *)params {
//    NSMutableString *str = [NSMutableString string];
//    
////    TODO - strip out escape characters from the string
////    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet];
////    str = [[str componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
//
//    for (id param in params) {
//        if (param!= [NSNull null] && [param isKindOfClass:[NSString class]]) {
//            [str appendFormat:@"%@/",param];
//        }
//    }
//    return str;
//}

- (void)getImage:(NSString*)path success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self.manager.baseURL.absoluteString stringByAppendingString:path]]];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    NSMutableSet *acceptableContentTypes = [requestOperation.responseSerializer.acceptableContentTypes mutableCopy];
    [acceptableContentTypes addObject:@"image/jpg"];
    requestOperation.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [requestOperation start];
}

- (void)postImage:(NSString*)path image:(UIImage*)image success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self.manager.baseURL.absoluteString stringByAppendingString:path]]];
    NSString *imageBase64 = [NSString stringWithFormat:@"\"%@\"", [UIImageJPEGRepresentation(image,1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    [request setHTTPBody:[imageBase64 dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFCompoundResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON responseObject: %@ ",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        
    }];
    [op start];
    
}

@end

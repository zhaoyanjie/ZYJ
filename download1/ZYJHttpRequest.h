//
//  ZYJHttpRequest.h
//  ZYJHttpRequest
//
//  Created by qianfeng01 on 15/8/28.
//  Copyright (c) 2015年 zhaoyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DownloadSuccessBlock)(NSMutableData *download);
typedef void (^DownloadFailedBlock)(NSError *error) ;





@interface ZYJHttpRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *_httpRequest;
    NSMutableData *_downloadData;
    
}
@property(nonatomic,strong)NSMutableData *downloadData;
@property(nonatomic,copy)DownloadSuccessBlock mySuccessBlock;
@property(nonatomic,copy)DownloadFailedBlock  myFailedBlock;

-(void)downloadDataWithUrl:(NSString *)url success:( DownloadSuccessBlock)successBlock failed:(DownloadFailedBlock)failedBlock;
-(void)postDataWithUrl:(NSString *)url paramString:(NSString *)paramStr success:(DownloadSuccessBlock)successBlock failed:(DownloadFailedBlock)failedBlock;






@end

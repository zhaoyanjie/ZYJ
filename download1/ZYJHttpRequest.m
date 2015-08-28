//
//  ZYJHttpRequest.m
//  ZYJHttpRequest
//
//  Created by qianfeng01 on 15/8/28.
//  Copyright (c) 2015年 zhaoyanjie. All rights reserved.
//

#import "ZYJHttpRequest.h"

@implementation ZYJHttpRequest

-(instancetype)init
{
    if (self=[super init]) {
        
    }
    return self;
}
//Get请求
-(void)downloadDataWithUrl:(NSString *)url success:(DownloadSuccessBlock)successBlock failed:(DownloadFailedBlock)failedBlock
{
    if (_httpRequest) {
        [_httpRequest release];
        _httpRequest=nil;
    }
    self.mySuccessBlock=successBlock;
    self.myFailedBlock=failedBlock;
    //创建可变请求
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //创建下载连接
    _httpRequest=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}
-(void)postDataWithUrl:(NSString *)url paramString:(NSString *)paramStr success:(DownloadSuccessBlock)successBlock failed:(DownloadFailedBlock)failedBlock
{
    if (_httpRequest) {
        [_httpRequest release];
        _httpRequest=nil;
        
    }
    self.mySuccessBlock=successBlock;
    self.myFailedBlock=failedBlock;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //设置请求方式
    request.HTTPMethod=@"POST";
    //设置请求头 设置请求的类型
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //拼接参数转化为NSData
    NSData *data=[paramStr dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody=data;
    [request setValue:[NSString stringWithFormat:@"%ld",data.length] forHTTPHeaderField:@"Content-Length"];
    _httpRequest=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清除旧数据
    [self.downloadData setLength:0];
    
}
//接收数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.downloadData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.mySuccessBlock) {
        self.mySuccessBlock(self.downloadData);
    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.myFailedBlock) {
        //回调
        self.myFailedBlock(error);
    }
}


@end

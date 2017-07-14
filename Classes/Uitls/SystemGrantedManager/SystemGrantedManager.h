//
//  SystemGrantedManager.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemGrantedManager : NSObject


// 检查是否有通讯录权限
+ (void) getGrantedContacts:(void (^ __nullable)(bool granted, CFErrorRef _Nullable error))completion;
//获取所有联系人姓名和电话 firstName lastName 最多限定500个数 社交白条用的
+ (NSMutableArray*_Nullable)getFirstLastContactsInfoWithCount:(NSInteger)count;
// 获取所有通讯录中的联系人，电话号码 fullName H5调用
+(NSMutableDictionary *_Nullable) getFullContactsInfoWithCount:(NSInteger)count;
// 获取所有通讯录个数 H5调用
+(CFIndex) getFullContactsCount;
// 当前联系人是否在通讯录中，在获取通讯录过程中比较是否在通讯录中 手机充值调用
+(void) getContactsIsNumberExist:(NSString*_Nullable)telephone search:(void (^ __nullable)(BOOL successed))completion;


//是否支持发短信
+(BOOL)isSupportMessage;


//是否支持相册
+(BOOL)isSupportPhotoLibrary;
+(BOOL)getPHPhotoLibraryStatus;//相册权限


//是否支持相机 摄像头
+(BOOL)isSupportCamera;
+(BOOL)isSupportCameraFront;//前置相机
+(BOOL)isSupportCameraRear;//后置相机
+(BOOL)getCameraStatus;//相机权限


// 检查是否有相机|麦克风权限: AVMediaTypeVideo(相机) | AVMediaTypeAudio（麦克风）
+ (void)authorizationStatusForMediaType:(NSString *_Nullable)mediaType status:(void (^ __nullable)(BOOL granted))completion;

// 检查是否有相册权限 for >=ios8
+ (void)photoAuthorStatus:(void (^ __nullable)(BOOL granted))completion;

@end







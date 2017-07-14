//
//  SystemGrantedManager.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "SystemGrantedManager.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>



@implementation SystemGrantedManager


// 检查是否有通讯录权限
+ (void) getGrantedContacts:(void (^ __nullable)(bool granted, CFErrorRef __nullable error))completion {
    
    ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
    switch (ABstatus) {
        case kABAuthorizationStatusAuthorized:// 已授权，可使用
            completion(YES, 0);
            break;
        case kABAuthorizationStatusDenied:// 未授权，且用户无法更新，如家长控制情况下
            completion(NO, 0);
            break;
        case kABAuthorizationStatusNotDetermined: {// 未进行授权选择
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    CFRelease(addressBook);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(granted, error);
                });
            });
        }
            break;
        case kABAuthorizationStatusRestricted:// 用户拒绝App使用
            completion(NO, 0);
            break;
        default:
            completion(NO, 0);
            break;
    }
}


+ (NSMutableArray* _Nullable)getFirstLastContactsInfoWithCount:(NSInteger)count{
    
    if (count < 0 || count > 500) {//取通讯录的上限为500
        count = 500;
    }
    NSMutableArray * arr = nil;
    //创建通讯簿的引用
    ABAddressBookRef addBook=ABAddressBookCreateWithOptions(NULL, NULL);
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    
    if (count >= 0 && number > count) {
        number = count;
    }
    
    //进行遍历
    for (NSInteger i=0; i<number; i++) {
        //获取联系人对象的引用
        ABRecordRef people = CFArrayGetValueAtIndex(allLinkPeople, i);
        //获取当前联系人名字
        CFTypeRef firstNameType = ABRecordCopyValue(people, kABPersonFirstNameProperty);
        NSString *firstName = CFBridgingRelease(firstNameType);
        //获取当前联系人姓氏
        
        CFTypeRef lastNameType = ABRecordCopyValue(people, kABPersonLastNameProperty);
        NSString*lastName = CFBridgingRelease(lastNameType);
        
        NSMutableArray * phoneArr = [[NSMutableArray alloc] init];
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            CFTypeRef telValue = ABMultiValueCopyValueAtIndex(phones, j);
            
            NSString* tel = [NSString stringWithFormat:@"%@",telValue];
            tel = [tel stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (telValue) {
                CFRelease(telValue);
            }
            NSLog(@"tel--->%@", tel);
            [phoneArr addObjectCheck:tel];
        }
        if (phones) {
            CFRelease(phones);
        }
        
        NSString *name = nil;
        NSString *phone = nil;
        if (firstName.length > 0 && lastName.length > 0) {
            name = [NSString stringWithFormat:@"%@%@", lastName, firstName];
        }else if (firstName.length == 0 && lastName.length > 0) {
            name = lastName;
        }else if (firstName.length > 0 && lastName.length == 0) {
            name = firstName;
        }
        
        if (phoneArr.count > 0) {
            phone = phoneArr.firstObject;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObjectCheck:name forKey:@"name"];
        [dict setObjectCheck:phone forKey:@"telephone"];
        if (!arr)
            arr = [[NSMutableArray alloc]init];
        [arr addObjectCheck:dict];
        NSLog(@"%@%@-%@", firstName,lastName, phoneArr);
    }
    
    if (addBook) {
        CFRelease(addBook);
    }
    
    if (allLinkPeople) {
        CFRelease(allLinkPeople);
    }
    return arr;
}
// 获取所有通讯录中的联系人，电话号码 fullName H5调用
+(NSMutableDictionary *_Nullable) getFullContactsInfoWithCount:(NSInteger)count
{
    
    // 如果不小于6.0，使用对应的api获取通讯录，注意，必须先请求用户的同意，如果未获得同意或者用户未操作，此通讯录的内容为空
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    // 通讯录信息已获得，开始取出
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    // 联系人条目数（使用long而不使用int是为了兼容64位）
    long peopleCount = CFArrayGetCount(results);
    if(peopleCount > count)
        peopleCount = count;
    NSMutableArray* contactsArr = [[NSMutableArray alloc] init];
    for (long i = 0; i < peopleCount; i++){
        
        ABRecordRef record = CFArrayGetValueAtIndex(results, i);
        NSMutableDictionary* oneDict = [[NSMutableDictionary alloc] init];
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // 取得完整名字
        CFStringRef fullName = ABRecordCopyCompositeName(record);
        NSString* name = [NSString stringWithFormat:@"%@",fullName];
        name = [name stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        [oneDict setObjectCheck:name forKey:@"name"];
        if (fullName){
            CFRelease(fullName);
            fullName = NULL;
        }
        
        // 读取电话,不只一个
        ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        long phoneCount = ABMultiValueGetCount(phones);
        for (long j = 0; j < phoneCount; j ++) {
            
            // phone number
            CFStringRef telValue = ABMultiValueCopyValueAtIndex(phones, j);
            NSString* tel = [NSString stringWithFormat:@"%@",telValue];
            tel = [tel stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
            tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            [arr addObjectCheck:tel];
            if (telValue){
                CFRelease(telValue);
                telValue = NULL;
            }
        }
        [oneDict setObjectCheck:arr forKey:@"telephoneArr"];
        if (phones){
            CFRelease(phones);
            phones = NULL;
        }
        
        [contactsArr addObjectCheck:oneDict];
    }
    
    if(results){
        CFRelease(results);
        results = NULL;
    }
    if(addressBook){
        CFRelease(addressBook); // 会崩溃，why
        addressBook = NULL;
    }
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObjectCheck:@(peopleCount) forKey:@"contactsCount"]; // 联系人总数
    [dict setObjectCheck:contactsArr forKey:@"contactsArr"];      // 联系人数据
    return dict;
}


// 获取所有通讯录个数 H5调用
+(CFIndex) getFullContactsCount
{
    // 如果不小于6.0，使用对应的api获取通讯录，注意，必须先请求用户的同意，如果未获得同意或者用户未操作，此通讯录的内容为空
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    // 通讯录信息已获得，开始取出
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    // 联系人条目数（使用long而不使用int是为了兼容64位）
    CFIndex peopleCount = CFArrayGetCount(results);
    
    
    if(results){
        CFRelease(results);
        results = NULL;
    }
    if(addressBook){
        CFRelease(addressBook);
        addressBook = NULL;
    }
    return peopleCount;
}



// 当前联系人是否在通讯录中，在获取通讯录过程中比较是否在通讯录中
+(void) getContactsIsNumberExist:(NSString*_Nullable)telephone search:(void (^ __nullable)(BOOL successed))completion {
    
    /*
    BOOL flag = [JRSystemInfo JRSystemGrantedContacts];
    if (NO ==  flag) {
        return NO;
    }*/
    
    @JDJRWeakify(self);
    [SystemGrantedManager getGrantedContacts:^(bool granted, CFErrorRef error) {
        @JDJRStrongify(self);
        if (!granted) {
  
            completion(NO);
            return;
        }
        
        // 在ios8系统以下包括ios8，调用下边的代码会崩溃
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (!addressBook){
            
            completion(NO);
            return;
        }
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (!results){
            completion(NO);
            return;
        }
        // 联系人条目数（使用long而不使用int是为了兼容64位）
        long peopleCount = CFArrayGetCount(results);
        if (peopleCount <=0) {
            if(results){
                CFRelease(results);
                results = NULL;
            }
            completion(NO);
            return ;
        }
        
        
        if (iPhone4) {
            // 大于3000个限制下
            if (peopleCount > 3000) {
                peopleCount = 3000;
            }
        }
        else if (iPhone5 && IOS10){
            // 大于3000个限制下
            if (peopleCount > 3000) {
                peopleCount = 3000;
            }
        }
        else{
            // 大于5000个限制下
            if (peopleCount > 5000) {
                peopleCount = 5000;
            }
        }
        
        BOOL bflag = NO;
        for (long i = 0; i < peopleCount; i++){
            
            ABRecordRef record = CFArrayGetValueAtIndex(results, i);
            
            // 读取电话,不只一个
            ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
            long phoneCount = ABMultiValueGetCount(phones);
            for (long j = 0; j < phoneCount; j ++) {
                
                // phone number
                CFStringRef telValue = ABMultiValueCopyValueAtIndex(phones, j);
                NSString* tel = [NSString stringWithFormat:@"%@",telValue];
                tel = [tel stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
                tel = [tel stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                tel = [tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
                tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
                tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                if (telValue){
                    CFRelease(telValue);
                    telValue = NULL;
                }
                if ([tel isEqualToString:telephone]) {
                    bflag = YES;
                    break;
                }        }
            if (phones){
                CFRelease(phones);
                phones = NULL;
            }
            if (record) {
                CFRelease(record);
                record = NULL;
            }
            if (YES == bflag) {
                break;
            }
        }
        
        if(results){
            CFRelease(results);
            results = NULL;
        }
        completion(bflag);
        return;
    }];
}


+(BOOL)isSupportMessage
{
    if ([MFMessageComposeViewController canSendText])
        return YES;
    else
        return NO;
}

+(BOOL)isSupportPhotoLibrary
{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
+(BOOL)getPHPhotoLibraryStatus
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
        return NO;
    return YES;
}

+(BOOL)isSupportCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
+(BOOL)isSupportCameraFront
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
+(BOOL)isSupportCameraRear
{
     return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
+(BOOL)getCameraStatus
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        return NO;
    return YES;
}


// 检查是否有相机|麦克风权限: AVMediaTypeVideo(相机) | AVMediaTypeAudio（麦克风） for >=ios8
+ (void)authorizationStatusForMediaType:(NSString *_Nullable)mediaType status:(void (^ __nullable)(BOOL granted))completion {
    
    if (!mediaType) {
        completion(NO);
        return;
    }
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:// 已授权，可使用
            completion(YES);
            break;
        case AVAuthorizationStatusDenied:// 未授权，且用户无法更新，如家长控制情况下
            completion(NO);
            break;
        case AVAuthorizationStatusNotDetermined: {// 未进行授权选择
            
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(granted);
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:// 用户拒绝App使用
            completion(NO);
            break;
        default:
            completion(NO);
            break;
    }
}



// 检查是否有相册权限 for >=ios8
+ (void)photoAuthorStatus:(void (^ __nullable)(BOOL granted))completion {
    
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            completion(YES);
            break;
        case PHAuthorizationStatusDenied:
            completion(NO);
            break;
        case PHAuthorizationStatusNotDetermined:{
            
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                BOOL successed = NO;
                if(status == PHAuthorizationStatusAuthorized){
                    successed = YES;
                }
                else{
                    successed = NO;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(successed);
                });
            }];
        }
            break;
        case PHAuthorizationStatusRestricted:
            completion(NO);
            break;  
        default:
            completion(NO);
            break;
    }
}


@end

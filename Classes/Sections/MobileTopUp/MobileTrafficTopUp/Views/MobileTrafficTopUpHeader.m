//
//  MobileTrafficTopUpHeader.m
//  JDMobile
//
//  Created by heweihua on 16/5/2.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpHeader.h"
#import "MobileTrafficEntity.h"
#import "UIBannerView.h"
#import "JRIousInputTextField.h"
#import "UITextField+JRAddition.h"

#define kHeadIconWH (28.f)



@interface MobileTrafficTopUpHeader ()
<UITextFieldDelegate>{
    
    UIButton *_headerbtn;
    UIView *_mobilebgview;

    NSInteger _tableIndex;
    NSArray   *_tableArr;
    
    UIBannerView* _banner;
}
@property(nonatomic, strong) JRIousInputTextField *mobileTextField;//手机号
@end

@implementation MobileTrafficTopUpHeader

-(void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTrafficTopUpMobileH + 10);
        
        // 轮播图
        [self initWithMobileTopUpBannerHeader];
        
        // 手机号输入框
        [self initTextField];
    }
    return self;
}

-(void) initWithMobileTopUpBannerHeader {
    
    _banner = [[UIBannerView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kMobileTopUpBannerH)];
    [self.contentView addSubview:_banner];
    _banner.hidden = YES;
    _banner.tag = 1;
}


-(void) buttonClicked:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickHeadButton)]) {
        [self.delegate didClickHeadButton];
    }
}


-(void) initTextField {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _mobilebgview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kMainScreenW, kMobileTrafficTopUpMobileH)];
    [_mobilebgview setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_mobilebgview];
    
    // 输入手机号
    CGFloat pointW = kMainScreenW - kOffsetX*2;
    CGRect rect = CGRectMake(kOffsetX, 10, pointW, 50);
    _mobileTextField = [[JRIousInputTextField alloc] initWithFrame:rect];
//    _mobileTextField.font = [UIFont getSanFranciscoFont:23.0 Weight:KSFWeightMedium];//21
    _mobileTextField.font = [UIFont systemFontOfSize:18.f];
    _mobileTextField.textColor = [UIColor jrColorWithHex:@"#444444"];
    _mobileTextField.floatingLabelText = @"请输入手机号码";
    _mobileTextField.textAlignment = NSTextAlignmentLeft;
    _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:@"#cccccc"];
    _mobileTextField.delegate = self;
    _mobileTextField.returnKeyType = UIReturnKeyDone;
    _mobileTextField.backgroundColor = [UIColor clearColor];
    _mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    UIButton *clearButton = [_mobileTextField valueForKey:@"_clearButton"];
    UIImage *image = [UIImage imageNamed:@"Login_icon_delete"];
    [clearButton setImage:image forState:UIControlStateNormal];
    
    [_mobileTextField setValue:[UIColor jrColorWithHex:@"#B0B0B0"]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [_mobilebgview addSubview:_mobileTextField];
    
    
    image = [UIImage imageNamed:@"contactsHead"];
    pointW = kHeadIconWH + kOffsetX*2;
    CGFloat pointX = kMainScreenW - pointW;
    _headerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerbtn.frame = CGRectMake(pointX, 0, pointW, kMobileTrafficTopUpMobileH);
    _headerbtn.backgroundColor = [UIColor clearColor];
    [_headerbtn setImage:image forState:UIControlStateNormal];
    [_headerbtn setImage:image forState:UIControlStateHighlighted];
    [_headerbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mobilebgview addSubview:_headerbtn];
}



#pragma mark - UITextFieldDelegate

-(void) textFieldDidChange:(UITextField *)textField{
    
    UITextRange * selectedRange = [textField markedTextRange];
    NSString * newText = [textField textInRange:selectedRange];
    if(newText.length>0)
        return;
    if (textField == self.mobileTextField){
        
        if(textField.text.length > 11){
            textField.text = [textField.text substringToIndex:11];
        }
    }
}



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 电话本复制过来的文本去掉-
    if (string) {
        string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (!text ||[text isEqualToString:@""]) {
        _headerbtn.hidden = NO;
        _mobileTextField.font = [UIFont systemFontOfSize:18.f];//21
        _mobileTextField.floatingLabelText = @"请输入手机号码";
        _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:kBlueColor];
        _mobileTextField.isFloatLabelActive = NO;
        
    }
    else{
        _headerbtn.hidden = YES;
        _mobileTextField.font = [UIFont getSanFranciscoFont:23.0 Weight:KSFWeightMedium];//21
        _mobileTextField.isFloatLabelActive = YES;
    }
    
    if (textField == self.mobileTextField){
        
        if (!(range.length == 0 && textField.text.length >= kMobileNumberMaxCount)){
            [self.mobileTextField jrchangeCharactersInRange:range replacementString:string whitePositions:@[@(3), @(8)]];
            NSString *tel = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([tel length] >= 11){
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(mobileTextFieldDidInputWithNumber:)]) {
                    
                    [_mobileTextField resignFirstResponder];
                    _mobileTextField.floatingLabelText = @"充值号码";
                    _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:@"#999999"];
                    
                    [self.delegate mobileTextFieldDidInputWithNumber:tel];
                    return NO;
                }
            }
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(mobileTextFieldDidInput:)]) {
            [self.delegate mobileTextFieldDidInput:NO];
        }
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    _mobileTextField.text = @"";
    _headerbtn.hidden = NO;
    _mobileTextField.font = [UIFont systemFontOfSize:18.f];//21
    _mobileTextField.floatingLabelText = @"请输入手机号码";
    _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:kBlueColor];
    _mobileTextField.isFloatLabelActive = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mobileTextFieldDidInput:)]) {
        [self.delegate mobileTextFieldDidInput:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([_mobileTextField.text isEqualToString:@""]) {
        _headerbtn.hidden = NO;
        _mobileTextField.floatingLabelText = @"请输入手机号码";
        _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:kBlueColor];
        _mobileTextField.isFloatLabelActive = NO;
    }
    else{
        _mobileTextField.isFloatLabelActive = YES;
    }
}



-(void) reloadDataWithTel:(NSString*)tel name:(NSString*)name{
    
    _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:kBlueColor];
    _mobileTextField.floatingLabelText = name;
    if ([tel length]==11) {
        
        NSMutableString* string = [NSMutableString stringWithFormat:@"%@",tel];
        NSInteger index = 0;
        while (index < string.length) {
            
            if(index == 3 || index == 8){
                
                [string insertString:@" " atIndex:index];
            }
            index++;
        }
        _mobileTextField.text = string;
    }
    else{
        _mobileTextField.text = tel;
    }
    
    if (!_mobileTextField.text ||[_mobileTextField.text isEqualToString:@""]) {
        _headerbtn.hidden = NO;
        _mobileTextField.font = [UIFont systemFontOfSize:18.f];//21
        _mobileTextField.floatingLabelText = @"请输入手机号码";
        _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:kBlueColor];
        _mobileTextField.isFloatLabelActive = NO;
    }
    else{
        
        _mobileTextField.font = [UIFont getSanFranciscoFont:23.0 Weight:KSFWeightMedium];//21
        _mobileTextField.isFloatLabelActive = YES;
    }
}




-(void) reloadDataWithTips:(NSString*)tips isErr:(BOOL) bErr{
    
    _mobileTextField.floatingLabelText = tips;
    if(bErr){
        _mobileTextField.floatingLabelActiveTextColor = [UIColor redColor];
        
    }
    else{
        _mobileTextField.floatingLabelActiveTextColor = [UIColor jrColorWithHex:@"#999999"];
    }
}



-(NSString*) getPhoneOperator{
    
    return _mobileTextField.floatingLabelText;
}




-(void) mobileTextFieldWithResignFirstResponder {
    [_mobileTextField resignFirstResponder];
}


#pragma mark - 键盘处理
#pragma mark 键盘即将显示
-(void) keyBoardWillShow:(NSNotification *)note{
    
    if (YES == _mobileTextField.isFirstResponder) {
        
        if ([_mobileTextField.text isEqualToString:@""]) {
            _headerbtn.hidden = NO;
        }
        else{
            _headerbtn.hidden = YES;
        }
        
        if ([_mobileTextField.text length] != kMobileNumberMaxCount){
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(mobileTextFieldDidInput:)]) {
                [self.delegate mobileTextFieldDidInput:NO];
            }
        }
        else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoardWillShow)]) {
                [self.delegate keyBoardWillShow];
            }
        }
    }
}

-(void) keyBoardWillHide:(NSNotification *)note{
    
    if (YES == _mobileTextField.isFirstResponder) {
        
        _headerbtn.hidden = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoardWillHide)]) {
            [self.delegate keyBoardWillHide];
        }
    }
}





-(void) reloadBannerData:(NSArray *)arr{
    
    if (!arr || [arr count] == 0) {
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTrafficTopUpMobileH + 10);
        CGRect rect = _mobilebgview.frame;
        rect.origin.y = 10;
        _mobilebgview.frame = rect;
        
        _banner.hidden = YES;
        return;
    }
    
    _banner.hidden = NO;
    [_banner reloadData:arr];
    self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTopUpBannerH + kMobileTrafficTopUpMobileH);
    CGRect rect = _mobilebgview.frame;
    rect.origin.y = kMobileTopUpBannerH;
    _mobilebgview.frame = rect;
}


-(CGFloat) getMobileMaxY {
    
//    CGRect rc = [self.contentView convertRect:_mobilebgview.frame fromView:_mobilebgview];
//    return CGRectGetMaxY(rc);
    
    return CGRectGetMaxY(self.frame);
}

@end



















//
//  ViewController.m
//  KeychainDemo
//
//  Created by lihongfeng on 16/8/25.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UITextView *searchResultTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)search:(id)sender {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"accountInfo" accessGroup:nil];
    NSString *account = [keychain objectForKey:(__bridge id)kSecAttrAccount];
    NSString *password = [keychain objectForKey:(__bridge id)kSecValueData];
    
    NSString *result = [account stringByAppendingString:[NSString stringWithFormat:@"\n%@", password]];
    
    self.searchResultTextView.text = @"";
    if (result.length > 0) {
        self.searchResultTextView.text = result;
    }
    
}

- (IBAction)clearCache:(id)sender {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"accountInfo" accessGroup:nil];
    [keychain resetKeychainItem];
}

- (IBAction)save:(id)sender {
    
    if (self.accountNameTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        return;
    }
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"accountInfo" accessGroup:nil];
    [keychain setObject:self.accountNameTextField.text forKey:(__bridge id)kSecAttrAccount];
    [keychain setObject:self.passwordTextField.text forKey:(__bridge id)kSecValueData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

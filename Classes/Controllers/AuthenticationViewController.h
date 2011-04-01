#import <UIKit/UIKit.h>


@interface AuthenticationViewController : UIViewController {
  IBOutlet UITextField *usernameField;
  IBOutlet UITextField *passwordField;
  IBOutlet UITableViewCell *usernameCell;
  IBOutlet UITableViewCell *passwordCell;
  IBOutlet UIBarButtonItem *doneButton;
  IBOutlet UIButton *helpBannerButton;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITableViewCell *usernameCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *passwordCell;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIButton *helpBannerButton;

+ (BOOL)signIn;
+ (void)retrieveUsername:(NSString **)username password:(NSString **)password;
+ (void)authenticate:(NSString *)username password:(NSString *)password;

- (IBAction)dismissDialog:(id)sender;
- (IBAction)saveCredentials:(id)sender;
- (IBAction)textDidChange:(id)sender;
- (IBAction)openTraktSite:(id)sender;

@end
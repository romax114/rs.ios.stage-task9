//
//  SettingsViewController.h
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

#import <UIKit/UIKit.h>
@class PaintingState;

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) PaintingState *state;
@end

NS_ASSUME_NONNULL_END

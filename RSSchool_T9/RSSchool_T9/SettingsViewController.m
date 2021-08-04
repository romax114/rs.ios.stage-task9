//
//  SettingsViewController.m
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

#import "SettingsViewController.h"
#import "RSSchool_T9-Swift.h"


@interface SettingsViewController () 

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureTableView];
    [self.tableView reloadData];
}

- (void)configureView {
    self.view.backgroundColor = [UIColor colorNamed:@"SettingsViewBackground"];
    self.title = @"Settings";
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:ColorTableViewCell.class forCellReuseIdentifier:@"colorCell"];
    [self.tableView registerClass:DrawTableViewCell.class forCellReuseIdentifier:@"drawCell"];
    [self.view addSubview:self.tableView];
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.scrollEnabled = NO;
    
}

- (void)configureTableView {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:120].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:104].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20].active = YES;
    
    self.tableView.layer.cornerRadius = 16.0;
}

// MARK: TableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drawCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.state = self.state;
        [cell configureWithSwitchIsOn:self.state.isSwitchedOn];
        return cell;
    } else {
        ColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colorCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.state = self.state;
        [cell configureWithHEXColor:cell.state.color];
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  52.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1){
        [self showColorSelector];
    }
}

- (void)showColorSelector {
    NSLog(@"show colors");
    ChooseColorViewController *chooseColorVC = [[ChooseColorViewController alloc] init];
    chooseColorVC.state = self.state;
    self.navigationController.navigationBar.tintColor = UIColor.redColor;
    [chooseColorVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.navigationController pushViewController:chooseColorVC animated:YES];
}

@end

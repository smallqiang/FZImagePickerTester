//
//  FZViewController.h
//  FZImagePickerTester
//
//  Created by Sujal Shah on 9/5/12.
//  Copyright (c) 2012 Forche LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,weak) IBOutlet UILabel* pickerOriginalSizeLabel;
@property (nonatomic,weak) IBOutlet UILabel* pickerEditedSizeLabel;
@property (nonatomic,weak) IBOutlet UILabel* pickerCropLabel;
@property (nonatomic,weak) IBOutlet UILabel* libraryOriginalSizeLabel;

@property (nonatomic,weak) IBOutlet UIButton* launchPickerButton;

@property (nonatomic,weak) IBOutlet UIImageView* imageView;

@property (nonatomic,assign) CGSize pickerOriginalSize;
@property (nonatomic,assign) CGSize pickerEditedSize;
@property (nonatomic,assign) CGRect pickerCropRect;
@property (nonatomic,assign) CGSize libraryOriginalSize;
@property (nonatomic,retain) UIImage* image;

@property (nonatomic,retain) UIPopoverController* popover;

- (IBAction)launchPickerTapped:(id)sender;

@end


//
//  FZViewController.m
//  FZImagePickerTester
//
//  Created by Sujal Shah on 9/5/12.
//  Copyright (c) 2012 Forche LLC. All rights reserved.
//

#import "FZViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FZViewController ()
- (void) updateLabelsForValues;
@end

@implementation FZViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.pickerOriginalSize = CGSizeZero;
        self.pickerEditedSize = CGSizeZero;
        self.libraryOriginalSize = CGSizeZero;
        self.pickerCropRect = CGRectZero;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateLabelsForValues];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self updateLabelsForValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)launchPickerTapped:(id)sender {
    
    self.pickerOriginalSize = CGSizeZero;
    self.pickerEditedSize = CGSizeZero;
    self.libraryOriginalSize = CGSizeZero;
    self.pickerCropRect = CGRectZero;
    self.image = nil;
    
    [self updateLabelsForValues];

    UIImagePickerController* controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.allowsEditing = YES;
    controller.delegate = self;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popover
         presentPopoverFromRect:self.launchPickerButton.frame
         inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popover = popover;
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
    
}

- (void) updateLabelsForValues {
    self.pickerOriginalSizeLabel.text = NSStringFromCGSize(self.pickerOriginalSize);
    self.pickerEditedSizeLabel.text = NSStringFromCGSize(self.pickerEditedSize);
    self.pickerCropLabel.text = NSStringFromCGRect(self.pickerCropRect);
    self.libraryOriginalSizeLabel.text = NSStringFromCGSize(self.libraryOriginalSize);
    
    self.imageView.image = self.image;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Image Picker Returned with info: %@", info);
    
    self.pickerOriginalSize = [(UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage] size];
    self.pickerEditedSize = [(UIImage*)[info objectForKey:UIImagePickerControllerEditedImage] size];
    self.pickerCropRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    
    NSURL *referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:referenceURL resultBlock:^(ALAsset *asset) {
        
        self.libraryOriginalSize = asset.defaultRepresentation.dimensions;
        self.image = (UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
        [self updateLabelsForValues];
        
    }
    failureBlock:^(NSError *error) {
        NSLog(@"Failed to get asset from referenceURL: %@\n\nError: %@\n", referenceURL, [error localizedDescription]);
    }];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];        
    }

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"Image Picker Canceled");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

}

@end

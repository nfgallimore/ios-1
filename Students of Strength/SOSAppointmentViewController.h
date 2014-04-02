//
//  SOSAppointmentViewController.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SOSAppointment.h"

@interface SOSAppointmentViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

@property SOSAppointment *appointment;

@end

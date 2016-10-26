//
//  LinterPlugin.h
//  CodaLintBackend
//
//  Created by Joseph Mehdi Smith on 10/26/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import <CodaLintBackend/CodaPluginsController.h>
#import <CodaLintBackend/LintParser.h>

@interface LinterPlugin : NSObject <CodaValidatorPlugIn, LintParser>

@property (nonatomic, strong) NSString* linterPath;
@property (nonatomic, strong) NSArray* linterArguments;

@end

//
//  LinterPlugin.h
//  CodaLintBackend
//
//  Created by Joseph Mehdi Smith on 10/26/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import <CodaLintBackend/CodaPluginsController.h>
#import <CodaLintBackend/LintParser.h>

@interface LinterPlugin : NSObject <CodaValidatorPlugIn>

@property (nonatomic, strong) NSString* linterPath;
@property (nonatomic, strong) NSArray* linterArguments;
@property (nonatomic, strong) LintParser* parser;

@end

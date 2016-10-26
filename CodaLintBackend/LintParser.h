//
//  LintParser.h
//  CodaLintBackend
//
//  Created by Joseph Mehdi Smith on 10/26/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#ifndef LintParser_h
#define LintParser_h

@protocol LintParser

- (NSArray *) parseLintErrors:(NSString *) output;

@end

#endif /* LintParser_h */

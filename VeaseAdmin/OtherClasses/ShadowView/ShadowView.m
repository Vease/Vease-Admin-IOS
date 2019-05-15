//
//  ShadowView.m
//  ConceptStore
//
//  Created by aliapple on 04/04/2019.
//  Copyright © 2019 Ali Apple. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset =  CGSizeMake(1, 1);
        self.layer.shadowRadius = 10.0;
        self.layer.shadowOpacity = .10;
    }
    return self;
}

@end

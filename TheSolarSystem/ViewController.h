//
//  ViewController.h
//  TheSolarSystem
//
//  Created by enghou on 17/4/25.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
@interface ViewController : GLKViewController

@property(nonatomic,assign)GLKMatrix4 modelMatrix;

@property(nonatomic,assign)GLKMatrix4 viewMatrix;

@property(nonatomic,assign)GLKMatrix4 projectionMatrix;

@end


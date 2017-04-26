//
//  BallView.h
//  TheSolarSystem
//
//  Created by enghou on 17/4/25.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import <GLKit/GLKit.h>
typedef struct {
    GLKVector3 position;
    GLKVector3 normal;
    GLKVector4 color;
    GLKVector2 texcoords;
}SceneVertex;
@interface BallView : NSObject

-(instancetype)initWithImage:(UIImage *)image;

@property(nonatomic,assign)GLKMatrix4 modelMatrix;

@property(nonatomic,assign)GLKMatrix4 viewMatrix;

@property(nonatomic,assign)GLKMatrix4 projectionMatrix;

@property(nonatomic,assign,readonly)GLuint texture;
-(void)draw;
@end

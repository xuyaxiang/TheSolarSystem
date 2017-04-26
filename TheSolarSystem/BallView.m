//
//  BallView.m
//  TheSolarSystem
//
//  Created by enghou on 17/4/25.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import "BallView.h"
#import "sphere.h"
@interface BallView()

@property(nonatomic,strong)CAEAGLLayer *elayer;

@end
@implementation BallView
{
    GLuint _program;
    NSInteger count;
    GLint _modelMat;//模型矩阵位置
    GLint _viewMat;//视图矩阵位置
    GLint _projectionMat;//投影矩阵位置
    GLint _tex;
    GLuint name;//array数组的名字
}
@synthesize texture;
-(instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        [self intializeData:image];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"earth.jpg"];
        [self intializeData:image];
    }
    return self;
}

-(void)draw{
    glUseProgram(_program);
    glBindTexture(GL_TEXTURE_2D, texture);
    glUniformMatrix4fv(_modelMat, 1, 0, _modelMatrix.m);
    glUniformMatrix4fv(_viewMat, 1, 0, _viewMatrix.m);
    glUniformMatrix4fv(_projectionMat, 1, 0, _projectionMatrix.m);
    glDrawArrays(GL_TRIANGLES, 0, count);
}

-(void)intializeData:(UIImage *)image{
    NSMutableData *data = [NSMutableData dataWithCapacity:sizeof(SceneVertex) * sphereNumVerts];
    count = sphereNumVerts;
    _modelMatrix = GLKMatrix4Identity;
    _viewMatrix = GLKMatrix4Identity;
    _projectionMatrix = GLKMatrix4Identity;
    for (int i = 0; i<count; ++i) {
        SceneVertex scene;
        scene.position.x = sphereVerts[3*i];
        scene.position.y = sphereVerts[3*i+1];
        scene.position.z = sphereVerts[3*i+2];
        scene.normal.x = sphereNormals[3*i];
        scene.normal.y = sphereNormals[3*i+1];
        scene.normal.z = sphereNormals[3*i+2];
        scene.texcoords.s = sphereTexCoords[2*i];
        scene.texcoords.t = sphereTexCoords[2*i+1];
        scene.color = GLKVector4Make(1, 1, 1, 1);
        [data appendBytes:&scene length:sizeof(SceneVertex)];
    }
    glEnable(GL_DEPTH_TEST);
    glGenBuffers(1, &name);
    glBindBuffer(GL_ARRAY_BUFFER, name);
    glBufferData(GL_ARRAY_BUFFER, [data length], [data bytes], GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL+offsetof(SceneVertex, color));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL+offsetof(SceneVertex, normal));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL+offsetof(SceneVertex, texcoords));
    
//    glActiveTexture(GL_TEXTURE_2D);
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    CGSize size = [self fixedSizeForImage:image];
    NSData *d = [self fixedDataWithWidth:size.width height:size.height image:image];
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, size.width, size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, [d bytes]);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glBindTexture(GL_TEXTURE_2D, 0);
    glUniform1i(_tex, 0);
    [self loadShaders];
}

-(NSData *)fixedDataWithWidth:(NSInteger)width height:(NSInteger)height image:(UIImage *)img{
    NSMutableData *data = [NSMutableData dataWithLength:width*height*4];
    CGColorSpaceRef color = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate([data mutableBytes], width, height, 8, width * 4, color, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(color);
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), img.CGImage);
    UIGraphicsEndImageContext();
    return [data copy];
}

-(CGSize)fixedSizeForImage:(UIImage *)image{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    unsigned int finally = 1;
    while (finally<width) {
        finally <<= 1;
    }
    width = finally;
    finally = 1;
    while (finally<height) {
        finally <<= 1;
    }
    height = finally;
    return CGSizeMake(width, height);
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    
    NSString *vertShaderPathname, *fragShaderPathname;
    
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    
    glBindAttribLocation(_program, GLKVertexAttribTexCoord0, "TextureCoords");
    
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        return NO;
    }
    _modelMat = glGetUniformLocation(_program, "modelMatrix");
    _viewMat = glGetUniformLocation(_program, "viewMatrix");
    _projectionMat = glGetUniformLocation(_program, "projectionMatrix");
    _tex = glGetUniformLocation(_program, "tex");//获取取样器的位置
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  YXVertexAttribArrayBuffer.h
//  TheSolarSystem
//
//  Created by enghou on 17/4/25.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import <GLKit/GLKit.h>

typedef enum {
    YXVertexAttribPosition = GLKVertexAttribPosition,
    YXVertexAttribNormal = GLKVertexAttribNormal,
    YXVertexAttribColor = GLKVertexAttribColor,
    YXVertexAttribTexCoord0 = GLKVertexAttribTexCoord0,
    YXVertexAttribTexCoord1 = GLKVertexAttribTexCoord1
}YXVertexAttrib;

@interface YXVertexAttribArrayBuffer : NSObject

@property(nonatomic,readonly)GLuint name;

@property(nonatomic,readonly)GLsizeiptr bufferSizeBytes;

@property(nonatomic,readonly)GLsizei stride;

+ (void)drawPreparedArraysWithMode:(GLenum)mode
                  startVertexIndex:(GLint)first
                  numberOfVertices:(GLsizei)count;

- (id)initWithAttribStride:(GLsizei)stride
          numberOfVertices:(GLsizei)count
                     bytes:(const GLvoid *)dataPtr
                     usage:(GLenum)usage;

- (void)prepareToDrawWithAttrib:(GLuint)index
            numberOfCoordinates:(GLint)count
                   attribOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable;

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;

- (void)reinitWithAttribStride:(GLsizei)stride
              numberOfVertices:(GLsizei)count
                         bytes:(const GLvoid *)dataPtr;

@end

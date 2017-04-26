//
//  YXShaderManager.h
//  YXRenderEngine
//
//  Created by enghou on 17/4/16.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

//位置属性
//颜色属性
//法线属性
//纹理属性

//模型变换矩阵统一变量
//视图变换矩阵统一变量
//投影变换矩阵统一变量
//纹理单元统一变量

//someOther统一变量

@interface YXShaderManager : NSObject

@property(nonatomic,assign,readonly)GLuint program;

-(instancetype)initWithDefault;//生成一个最基本的shader

-(instancetype)initWithVertexShader:(NSString *)vPath fragShader:(NSString *)fShader;

@end

//
//  ViewController.m
//  TheSolarSystem
//
//  Created by enghou on 17/4/25.
//  Copyright © 2017年 xyxorigation. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *ballArray;
- (IBAction)changeDistance:(id)sender;
@end

@implementation ViewController
{
    CGFloat distance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:view.context];
    glClearColor(1, 1, 1, 1);
    _ballArray = [NSMutableArray array];
    NSArray *name = @[@"sun.bmp",@"shuixing.jpg",@"jinxing.jpg",@"earth.jpg",@"huoxing.jpg",@"muxing.jpg",@"tuxing.jpg",@"tianwangxing.jpg",@"haiwangxing.jpg"];
    for (int i = 0; i<[name count]; i++) {
        UIImage *image = [UIImage imageNamed:name[i]];
        BallView *ball = [[BallView alloc]initWithImage:image];
        ball.modelMatrix = GLKMatrix4Identity;
        ball.viewMatrix = GLKMatrix4MakeLookAt(0, 200, 0, 0, 0, 0, 0, 0, 1);
//        ball.viewMatrix = GLKMatrix4MakeLookAt(0, 0, 200, 0, 0, 0, 0, 1, 0);
        ball.projectionMatrix = GLKMatrix4MakeFrustum(-5, 5, -5, 5, 8, 1000);
        [_ballArray addObject:ball];
    }
    glViewport(0, 0, (GLsizei)self.view.frame.size.width, (GLsizei)self.view.frame.size.height);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)update{
    static float i = 0;
    BallView *ball1 = _ballArray[0];
    GLfloat aspect = (GLfloat)self.view.frame.size.width / (GLfloat)self.view.frame.size.height;
    ball1.modelMatrix = GLKMatrix4MakeScale(25, 25*aspect, 25);
    ball1.modelMatrix = GLKMatrix4Rotate(ball1.modelMatrix, GLKMathDegreesToRadians(5*i), 0, 1, 0);
    
    BallView *ball2 = _ballArray[1];
    ball2.modelMatrix = GLKMatrix4Identity;
    ball2.modelMatrix = GLKMatrix4Scale(ball2.modelMatrix, 20, 20*aspect, 20);
    ball2.modelMatrix = GLKMatrix4Rotate(ball2.modelMatrix, GLKMathDegreesToRadians(5*i), 0, 1, 0);
    ball2.modelMatrix = GLKMatrix4Translate(ball2.modelMatrix, 0, 0, -2);
    ball2.modelMatrix = GLKMatrix4Rotate(ball2.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    BallView *ball3 = _ballArray[2];
    ball3.modelMatrix = GLKMatrix4MakeScale(16, 16*aspect, 16);
    ball3.modelMatrix = GLKMatrix4Rotate(ball3.modelMatrix, GLKMathDegreesToRadians(i*4.8), 0, 1, 0);
    ball3.modelMatrix = GLKMatrix4Translate(ball3.modelMatrix, 0, 0, -5);
    ball3.modelMatrix = GLKMatrix4Rotate(ball3.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    
    BallView *ball4 = _ballArray[3];
    ball4.modelMatrix = GLKMatrix4MakeScale(14, 14*aspect, 14);
    ball4.modelMatrix = GLKMatrix4Rotate(ball4.modelMatrix, GLKMathDegreesToRadians(i*4.5), 0, 1, 0);
    ball4.modelMatrix = GLKMatrix4Translate(ball4.modelMatrix, 0, 0, -8);
    ball4.modelMatrix = GLKMatrix4Rotate(ball4.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    
    
    BallView *ball5 = _ballArray[4];
    ball5.modelMatrix = GLKMatrix4MakeScale(12, 12*aspect, 12);
    ball5.modelMatrix = GLKMatrix4Rotate(ball5.modelMatrix, GLKMathDegreesToRadians(i*4.3), 0, 1, 0);
    ball5.modelMatrix = GLKMatrix4Translate(ball5.modelMatrix, 0, 0, -10);
    ball5.modelMatrix = GLKMatrix4Rotate(ball5.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    
    
    BallView *ball6 = _ballArray[5];
    ball6.modelMatrix = GLKMatrix4MakeScale(10, 10*aspect, 10);
    ball6.modelMatrix = GLKMatrix4Rotate(ball6.modelMatrix, GLKMathDegreesToRadians(i*4.1), 0, 1, 0);
    ball6.modelMatrix = GLKMatrix4Translate(ball6.modelMatrix, 0, 0, -12);
    ball6.modelMatrix = GLKMatrix4Rotate(ball6.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    
    BallView *ball7 = _ballArray[6];
    ball7.modelMatrix = GLKMatrix4MakeScale(8, 8*aspect, 8);
    ball7.modelMatrix = GLKMatrix4Rotate(ball7.modelMatrix, GLKMathDegreesToRadians(i*3.5), 0, 1, 0);
    ball7.modelMatrix = GLKMatrix4Translate(ball7.modelMatrix, 0, 0, 3);
    ball7.modelMatrix = GLKMatrix4Rotate(ball7.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    
    
    BallView *ball8 = _ballArray[7];
    ball8.modelMatrix = GLKMatrix4MakeScale(6, 6*aspect, 6);
    ball8.modelMatrix = GLKMatrix4Rotate(ball8.modelMatrix, GLKMathDegreesToRadians(i*2), 0, 1, 0);
    ball8.modelMatrix = GLKMatrix4Translate(ball8.modelMatrix, 0, 0, 5);
    ball8.modelMatrix = GLKMatrix4Rotate(ball8.modelMatrix, GLKMathDegreesToRadians(3*i), 0, 1, 0);
    i+=0.1;
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
//     [_ballArray[0] performSelector:@selector(draw) withObject:nil];
//    [_ballArray[1] performSelector:@selector(draw) withObject:nil];
    [_ballArray makeObjectsPerformSelector:@selector(draw)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeDistance:(id)sender {
    distance += 0.1;
}
@end

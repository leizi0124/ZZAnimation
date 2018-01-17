//
//  AnimationVC1.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/3.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC1.h"
#import "BaseTableView.h"
#import <objc/message.h>
#import <CoreText/CoreText.h>
#import <OpenAL/OpenAL.h>
#import <GLKit/GLKit.h>
@interface AnimationVC1 ()<BaseTableViewDelegate>
{
    BaseTableView *tableview;
    NSArray *dataArray;
    UIView *animationView;
    
    UIView *glView;
    EAGLContext *glContext;
    CAEAGLLayer *glLayer;
    GLuint framebuffer;
    GLuint colorRenderbuffer;
    GLint framebufferWidth;
    GLint framebufferHeight;
    GLKBaseEffect *effect;
}
@end
@implementation AnimationVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = @[@"UIView:[beginAnimations:->commitAnimations]",
                  @"UIView animateWithDuration:animations:completion:",
                  @"CATextLayer",
                  @"CATextLayer 富文本",
                  @"CATransformLayer 立体",
                  @"CAGradientLayer 渐变色",
                  @"CAReplicatorLayer 重复绘制",
                  @"CATiledLayer 大图片分块加载",
                  @"CAEAGLLayer GLKit + OpenGLES",
                  @"AVPlayerLayer 视频播放"];
    
    tableview = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataArray = dataArray;
    [self.view addSubview:tableview];
    
    animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor blackColor];
    animationView.alpha = 0.5;
    animationView.userInteractionEnabled = NO;
    [self.view addSubview:animationView];
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    NSString *methodName = [NSString stringWithFormat:@"animation%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
#pragma mark - UIView:[beginAnimations:->commitAnimations]
- (void)animation1 {
    [UIView beginAnimations:@"viewanimation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    animationView.frame = self.view.bounds;
    animationView.backgroundColor = [UIColor redColor];
    animationView.alpha = 1;
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationDefault];
    });
}
#pragma mark - UIView animateWithDuration:animations:
- (void)animation2 {
    [UIView animateWithDuration:1.0 animations:^{
        animationView.frame = self.view.bounds;
        animationView.backgroundColor = [UIColor greenColor];
        animationView.alpha = 1;
    } completion:^(BOOL finished) {
        [self animationDefault];
    }];
}
- (void)animation3 {
    NSLog(@"初始化");
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = animationView.bounds;
    [animationView.layer addSublayer:textLayer];

    textLayer.foregroundColor = [UIColor redColor].CGColor;     //字体颜色
    textLayer.alignmentMode = kCAAlignmentCenter;               //显示位置
    textLayer.wrapped = YES;                                    //是否换行
    UIFont *font = [UIFont systemFontOfSize:15];                //字体大小
    CFStringRef fontName = (__bridge CFStringRef)font.fontName; //字体名
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);     //设置字体名
    textLayer.font = fontRef;                                   //字体名
    textLayer.fontSize = font.pointSize;                        //字体大小
    CGFontRelease(fontRef);                                     //释放字体名
    NSString *text = @"测试CALayer  111222";                     //设置显示文字
    textLayer.contentsScale = [UIScreen mainScreen].scale;      //防止像素化
    textLayer.string = text;
}
- (void)animation4 {
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = animationView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [animationView.layer addSublayer:textLayer];
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:15];
    NSString *text = @"测试CALayer  111222";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //设置文字显示
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor redColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    
    //设置下划线显示
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor greenColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(2, 7)];
    CFRelease(fontRef);

    textLayer.string = string;
}
- (void)animation5 {
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self layerWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 0, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    
    //apply the transform and return
    cube.transform = c2t;
    
    [self.view.layer addSublayer:cube];
}
- (CALayer *)layerWithTransform:(CATransform3D)transform {
    CALayer *transformLayer = [CALayer layer];
    transformLayer.frame = CGRectMake(-50, -50, 100, 100);

    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    transformLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    transformLayer.transform = transform;
    return transformLayer;
}
- (void)animation6 {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = animationView.bounds;
    [animationView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id) [UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    
    gradientLayer.locations = @[@0.3, @0.6, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}
- (void)animation7 {
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = animationView.bounds;
    [animationView.layer addSublayer:replicator];

    replicator.instanceCount = 10;

    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 0, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, 0, 0);
    replicator.instanceTransform = transform;

    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(animationView.frame.size.width / 2.0 - 10, 0, 10, 10);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [replicator addSublayer:layer];
}
- (void)animation8 {
    
}
- (void)animation9 {
    glView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:glView];
    //set up context
    glContext = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glContext];
    
    //set up layer
    glLayer = [CAEAGLLayer layer];
    glLayer.frame = glView.bounds;
    [glView.layer addSublayer:glLayer];
    glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@NO, kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8};
    
    //set up base effect
    effect = [[GLKBaseEffect alloc] init];
    
    //set up buffers
    [self setUpBuffers];
    
    //draw frame
    [self drawFrame];
}
- (void)setUpBuffers {
    //set up frame buffer
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    
    //set up color render buffer
    glGenRenderbuffers(1, &colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
    [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:glLayer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &framebufferHeight);
    
    //check success
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"Failed to make complete framebuffer object: %i", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}
- (void)tearDownBuffers {
    if (framebuffer) {
        
        glDeleteFramebuffers(1, &framebuffer);
        framebuffer = 0;
    }
    
    if (colorRenderbuffer) {
        
        glDeleteRenderbuffers(1, &colorRenderbuffer);
        colorRenderbuffer = 0;
    }
}
- (void)drawFrame {
    //bind framebuffer & set viewport
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glViewport(0, 0, framebufferWidth, framebufferHeight);
    
    //bind shader program
    [effect prepareToDraw];
    
    //clear the screen
    glClear(GL_COLOR_BUFFER_BIT); glClearColor(0.0, 0.0, 0.0, 1.0);
    
    //set up vertices
    GLfloat vertices[] = {
        -0.5f, -0.5f, -1.0f, 0.0f, 0.5f, -1.0f, 0.5f, -0.5f, -1.0f,
    };
    
    //set up colors
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f,
    };
    
    //draw triangle
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor,4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    //present render buffer
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    [glContext presentRenderbuffer:GL_RENDERBUFFER];
}
- (void)viewDidUnload {
    [self tearDownBuffers];
    [super viewDidUnload];
}

- (void)dealloc {
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}
- (void)animation10 {
    
}
- (void)animationDefault {
    animationView.frame = CGRectMake(0, 0, 100, 100);
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor blackColor];
    animationView.alpha = 0.5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

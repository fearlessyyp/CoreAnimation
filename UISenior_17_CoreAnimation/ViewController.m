//
//  ViewController.m
//  UISenior_17_CoreAnimation
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testView;

@property (weak, nonatomic) IBOutlet UIView *myView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
//#pragma mark - Layer的常用属性
//    // 设置图片为圆角
//    self.testView.layer.cornerRadius = 20;
////    // 子图层是否相对于父图层裁剪,但如果加上这句话，设置的阴影效果就不显示
////    self.testView.layer.masksToBounds = YES;
//    // 设置阴影的偏移量
//    self.testView.layer.shadowOffset = CGSizeMake(10, 10);
//    // 设置layer的阴影颜色
//    self.testView.layer.shadowColor = [UIColor grayColor].CGColor;
//    // 设置阴影的透明度
//    self.testView.layer.shadowOpacity = 1;
//    // 设置阴影的模糊度
//    self.testView.layer.shadowRadius = 20;
//    
//    // 设置UIView的阴影
//    self.myView.layer.shadowOffset = CGSizeMake(-10, 10);
//    self.myView.layer.shadowColor = [UIColor greenColor].CGColor;
//    self.myView.layer.shadowOpacity = 1;
//    self.myView.layer.shadowRadius = 20;
    
    
    // 自定义layer
//    [self customLayer];

}

#pragma mark - 自定义layer
- (void)customLayer {
    // 创建一个layer对象
    CALayer *layer = [CALayer layer];
    // 设置Layer对象的位置
    layer.frame = CGRectMake(0, 280, 100, 100);
    // 设置背景颜色
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    // 设置锚点
    layer.anchorPoint = CGPointMake(0, 0);
    // 设置位置
    layer.position = CGPointMake(200, 200);
    
    // 将自定义layer添加到self.view的layer层
    [self.view.layer addSublayer:layer];
}

#pragma mark - CABasicAnimation动画按钮的响应方法
- (IBAction)basicAnimation:(id)sender {
    // ***********路径动画***********
    // 第一步：创建动画对象
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    // 第二步：设置动画轨迹,告诉layer层需要执行什么样的动画，设置的内容为CALayer的相关属性
    basicAnimation.keyPath = @"position";
    // 第三部：设置初始位置和最终位置
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    // 第四步：如果要设置动画完成后不回到初始状态，需要实现以下两句代码
    // 动画执行完毕后不从图层上移除,图形不会恢复到动画执行前的状态
    basicAnimation.removedOnCompletion = NO;
    // 设置保存动画状态
    basicAnimation.fillMode = kCAFillModeForwards;
    // 第四步：设置动画时长
    basicAnimation.duration = 6.0f;
    // 第五步：将BasicAnimation动画添加到CALayer上
    [self.testView.layer addAnimation:basicAnimation forKey:@"basic"];
    
    // **********旋转效果***********
    CABasicAnimation *basic = [CABasicAnimation animation];
    basic.keyPath = @"transform";
    // 参数1：value值：角度 最大旋转180°，就是会按照你设定的角度得到的效果的最短距离去旋转，如果是360°的倍数就静止不动
    // 参数2：x  沿x轴旋转 纵向翻转
    // 参数3：y  沿y轴旋转 横向翻转
    // 参数4：z  沿z轴旋转 平面旋转
    basic.toValue = [NSValue valueWithCATransform3D:
    CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    basic.duration = 2.0;
    [self.testView.layer addAnimation:basic forKey:@"transform"];
    
    // 根据key移除动画
    [self.testView.layer removeAnimationForKey:@"basic"];
    
    // ***********改变内容************
    CABasicAnimation *contents = [CABasicAnimation animation];
    contents.keyPath = @"contents";
    contents.toValue = (id)[UIImage imageNamed:@"2.jpg"].CGImage;
    contents.duration = 1.0f;
    contents.repeatCount = MAXFLOAT;  // 动画无限循环
    contents.delegate = self;
    
    [self.testView.layer addAnimation:contents forKey:@"contents"];
    
    // 根据key移除动画
    [self.testView.layer removeAnimationForKey:@"transform"];
    

    
}

#pragma mark - CAKeyframeAnimation帧动画按钮的响应方法
- (IBAction)keyframeAnimation:(id)sender {
    // 第一步：创建对象
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animation];
    // 第二步：设置动画轨迹  平面图的旋转
    keyframe.keyPath = @"transform.rotation";
    // 第三步：设置旋转角度(弧度的计算公式:度数/180 * MPI);
    keyframe.values = @[@(-4 / 180.0 * M_PI), @(4 / 180.0 * M_PI), @(8 / 180.0 * M_PI)];

    // 第四步：设置动画时长
    keyframe.duration = 3.0f;
    // 第五步：添加动画到layer层
    [self.testView.layer addAnimation:keyframe forKey:@"keyfraome"];
    
}

#pragma mark - CAAnimationGroup组动画按钮的响应方法
- (IBAction)animationGroup:(id)sender {
    // 平移动画
    CABasicAnimation *basic1 = [CABasicAnimation animation];
    // y轴平移
    basic1.keyPath = @"transform.translation.y";
    basic1.toValue = @(400);
    // 翻转动画
    CABasicAnimation *basic2 = [CABasicAnimation animation];
    basic2.keyPath = @"transform.rotation.x";
    basic2.toValue = @(M_PI);
    
    // 旋转动画
    CABasicAnimation *basic3 = [CABasicAnimation animation];
    basic3.keyPath = @"cornerRadius";
    basic3.toValue = @(30);

    
    // 创建动画组，管理各个动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 数组中存放的是layer层的动画
    group.animations = @[basic1, basic2, basic3];
    // 设置动画时长
    group.duration = 2.0f;
    group.removedOnCompletion = NO;
    // 设置保存动画状态
    group.fillMode = kCAFillModeForwards;
    // 添加动画到layer层
    [self.testView.layer addAnimation:group forKey:@"group"];
}

#pragma mark - CASpringAnimation动画按钮的响应方法
- (IBAction)springAnimation:(id)sender {
    CASpringAnimation *springAnimation = [CASpringAnimation animation];
    
    springAnimation.keyPath = @"transform.scale";
    springAnimation.fromValue = @1;
    springAnimation.toValue = @0.25;
    springAnimation.duration = 3.0f;
    
    [self.testView.layer addAnimation:springAnimation forKey:@"spring"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //
    NSLog(@"动画结束");
}

@end

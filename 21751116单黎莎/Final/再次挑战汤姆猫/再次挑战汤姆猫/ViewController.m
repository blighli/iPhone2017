//
//  ViewController.m
//  再次挑战汤姆猫
//
//  Created by Edith.S on 2016/12/25.
//  Copyright © 2016年 Edith.S. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/**这是一只不会说话的汤姆猫*/
@property (weak, nonatomic) IBOutlet UIImageView *tomcat;

//hit tom's body
- (IBAction) knockOut;
- (IBAction) angry;
- (IBAction) stomach;
- (IBAction) leftFoot;
- (IBAction) rightFoot;

//six buttons
- (IBAction) eat;
- (IBAction) pie;
- (IBAction) drink;
- (IBAction) scratch;
- (IBAction) cymbal;
- (IBAction) fart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 动画播放方法
 *   传入参数：
 *   imageCount：播放帧动画的图片数量
 *   imageNmae：播放帧动画的图片名
 *   返回值为空
 */
-(void) animationPlayWithCount:(int)imageCount andName:(NSString*) imageName{
    //获取图片文件
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i =0; i<imageCount; i++) {
        //构造文件名
        NSString *name = [NSString stringWithFormat:@"%@_%02d",imageName, i];
        //获取文件路径
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:name ofType:@"jpg"];
        
        NSLog(@"%@",path);
        
        //通过路径获取图片
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        NSLog(@"%@",image);
        
        //将图片存入数组
        [images addObject:image];
        //NSLog(@"%@",images);
        
    }
    //设定播放的图片
    self.tomcat.animationImages = images;
    //设定动画持续时间
    self.tomcat.animationDuration = images.count *0.05;
    //set the number of cycle
    self.tomcat.animationRepeatCount = 1;
    //开始播放动画
    [self.tomcat startAnimating];
    
    //在开始播放动画一段时间之后清空数组
    [self.tomcat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:(imageCount*0.05+1)];
    
}

//会心一击
- (IBAction)knockOut {
    [self animationPlayWithCount:81 andName:@"knockout"];
}

//汤姆猫的尾巴摸不得
- (IBAction) angry{
    [self animationPlayWithCount:26 andName:@"angry"];
}

//大姨妈疼的汤姆猫？
- (IBAction) stomach{
    [self animationPlayWithCount:34 andName:@"stomach"];
}

- (IBAction) leftFoot{
    [self animationPlayWithCount:30 andName:@"footLeft"];
}

- (IBAction) rightFoot{
    [self animationPlayWithCount:30 andName:@"footRight"];
}

//catch a bird and eat it
- (IBAction) eat{
    [self animationPlayWithCount:40 andName:@"eat"];
}

//get a pie and throw it
- (IBAction) pie{
    [self animationPlayWithCount:24 andName:@"pie"];
}

//enjoy milk time
- (IBAction) drink{
    [self animationPlayWithCount:81 andName:@"drink"];
}

//磨爪子的汤姆猫
- (IBAction) scratch{
    [self animationPlayWithCount:56 andName:@"scratch"];
}

//”哐～～～～“
- (IBAction) cymbal{
    [self animationPlayWithCount:13 andName:@"cymbal"];
}

//毫不掩饰的放屁行为
- (IBAction) fart{
    [self animationPlayWithCount:28 andName:@"fart"];
}

@end

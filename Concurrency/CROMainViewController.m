//
//  CROMainViewController.m
//  Concurrency
//
//  Created by Jose Manuel Franco on 11/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROMainViewController.h"

@interface CROMainViewController ()

@end

@implementation CROMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)syncDownload:(id)sender {
    NSURL *imgURL =[NSURL URLWithString:@"http://aguabendita.com/media/catalog/product/cache/6/image/9df78eab33525d08d6e5fb8d27136e95/a/g/agua-bendita-bendito-fuego-bikini-3.jpg"];
    
    NSData *data=[NSData dataWithContentsOfURL:imgURL];
    UIImage *img=[UIImage imageWithData:data];
    self.photoView.image=img;
    
}

- (IBAction)asyncDownload:(id)sender {
    
    //crear una cola
    dispatch_queue_t descarga= dispatch_queue_create("async", 0);
    
    //Le mando un bloque

    dispatch_async(descarga, ^{
        NSURL *imgURL =[NSURL URLWithString:@"http://aguabendita.com/media/catalog/product/cache/6/image/9df78eab33525d08d6e5fb8d27136e95/a/g/agua-bendita-bendito-fuego-bikini-3.jpg"];
        
        NSData *data=[NSData dataWithContentsOfURL:imgURL];
        UIImage *img=[UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoView.image=img;
        });
        
    });
    
    
}

- (IBAction)asyncDownloadPro:(id)sender {
    [self withImage:^(UIImage *image) {
        self.photoView.image=image;
    }];
}

#pragma mark -Utils
-(void)withImage:(void (^)(UIImage* image))completionBlock{
    
    //Nos vamos a segundo plano a descargar la imagen
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSURL *imgURL =[NSURL URLWithString:@"http://www.laurela.com/products_img/1840140314agua-bendita-cinnamon-roll-swimsuit-big1.jpg"];
        
        NSData *data=[NSData dataWithContentsOfURL:imgURL];
        UIImage *img=[UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(img);
        });

        
        
        
        
    });
    //cuando la tengo la me voy a primer plano
    //llamo al completion block
    
    
}



@end

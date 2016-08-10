//
//  ViewController.m
//  AudioPlayer
//
//  Created by new on 10.08.16.
//  Copyright © 2016 F&G. All rights reserved.
//

#import "ViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController () {
    AVAudioPlayer * avPlayer;
}

@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
- (IBAction)sliderVolumeAction:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)playButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

// Добавление картинки на бэкграунд view
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"textures.jpg"] drawInRect:self.view.bounds];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    NSString * stringPath = [[NSBundle mainBundle] pathForResource:@"Dj Rain" ofType:@"mp3"];
    NSURL * myUrl = [NSURL fileURLWithPath:stringPath];
    
    NSError * error;
    
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:myUrl error:&error];
    
    [avPlayer setNumberOfLoops:2];
    
    [avPlayer setVolume:self.sliderVolume.value];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMyProgress) userInfo:nil repeats:YES];
    
}

- (void) updateMyProgress {
    
    float progress = [avPlayer currentTime] / [avPlayer duration];
    self.myProgressView.progress = progress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderVolumeAction:(id)sender {
    
    UISlider * mySlider = sender;
    [avPlayer setVolume:mySlider.value];
}

- (IBAction)stopButton:(id)sender {
    
    [avPlayer stop];
    [avPlayer setCurrentTime:0];
}

- (IBAction)pauseButton:(id)sender {
    
    [avPlayer pause];
}

- (IBAction)playButton:(id)sender {
    
    [avPlayer play];
}

@end

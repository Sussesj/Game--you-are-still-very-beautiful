
#import "ViewController.h"

@implementation ViewController
@synthesize myLabel;
@synthesize myLabelTo;
@synthesize myLevel;
@synthesize myScore;
bool contact = NO; 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Make the background white
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Configure the accelerometer
    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    // Use 30Hz update frequency
    theAccelerometer.updateInterval = 1 / 30;
    theAccelerometer.delegate = self;
    
    // Initialize the velocity vector
    ballVelocity.x=0.95;
    ballVelocity.y=0.95;
    trianglVelocity.x = 1.2;
    trianglVelocity.y = 1.5;
    
    
    // Draw the tiger
    tiger = [[UIImageView alloc] initWithImage:
             [UIImage imageNamed:@"circle.png"]];
    
    CGSize tigerSize = [tiger.image size];
    
    [tiger setFrame:CGRectMake(120.0, 140.0,
                               tigerSize.width, tigerSize.height)];
    
    [self.view addSubview:tiger];
    
    // Draw the triangle
    triangl = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"triangl.png"]];
    
    CGSize trianglSize = [triangl.image size];
    
    [triangl setFrame:CGRectMake(200.0, 220.0,
                              trianglSize.width, trianglSize.height)];
    
    // Set the initial velocity for the triangl
//    trianglVelocity = CGPointMake(0.95, 0.95);

    
    [self.view addSubview:triangl];
    // Set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self
                                            selector:@selector(updateDisplay:)];
    
    
    // Add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop]
                    forMode:NSDefaultRunLoopMode];
    score = 0;
    scoreTime = 0;
    triangl.center = tcenter;
    
    
    // Draw the ball
    ball = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"polygon.png"]];
    
    CGSize ballSize = [ball.image size];
    
    [ball setFrame:CGRectMake(200.0, 220.0,
                              ballSize.width, ballSize.height)];
    
    [self.view addSubview:ball];
    
    // Set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self
                                            selector:@selector(updateDisplay:)];
    
    
    // Add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop]
                    forMode:NSDefaultRunLoopMode];
    score = 0;
    level = 0; 
    scoreTime = 0;
    
    //-----------Sound
    //Path for our sound:
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"aiff"];
    CFURLRef soundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID(soundURL, &sounds[0]);
    
    AudioServicesPlaySystemSound(sounds[0]);
    
}

- (void)accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration
{
    
    //Add a numer to X to make the acceleroeter to quicker.
    ballVelocity.x += acceleration.x;
    ballVelocity.y -= acceleration.y;
    
    //trianglVelocity.x += acceleration.x;
    //trianglVelocity.y -= acceleration.y;
    
}

-(void) updateDisplay:(CADisplayLink*)sender
{
    // This method is called by the gameTimer each time the display should
    // update
    
    CGPoint center = ball.center;
    
    // Stop the ball if it's reached a boundary
    if (center.x<0 || center.x > self.view.bounds.size.width) {
        ballVelocity.x= -1 * ballVelocity.x;
    }
    if (center.y<0 || center.y>self.view.bounds.size.height)
    {
        ballVelocity.y= -1 * ballVelocity.y;
    }
    
    // Move the ball
    
    center.x = center.x + ballVelocity.x;
    center.y = center.y + ballVelocity.y;
    
    ball.center = center;
    
    [self checkCollisionWithTiger];
    
    //For Triangle moving
    //CGPoint tcenter = triangl.center;
    
    // Stop the triangl if it's reached a boundary
    if (tcenter.x<0 || tcenter.x > self.view.bounds.size.width) {
        trianglVelocity.x= -1 * trianglVelocity.x;
    }
    if (tcenter.y<0 || tcenter.y>self.view.bounds.size.height)
    {
        trianglVelocity.y= -1 *trianglVelocity.y;
    }
    
    tcenter.x = tcenter.x + trianglVelocity.x;
    tcenter.y = tcenter.y + trianglVelocity.y;
    triangl.center = tcenter;
    
    
    
    [self checkCollisionWithTiger];
    
   
}
-(void) checkCollisionWithTiger{
    
    //Check to see if BALL is colliding with tiger(middle ball
    if (CGRectIntersectsRect(ball.frame, tiger.frame)) {
        score++;
        if (score == 1) {
            level --;
             NSString* scoreLabel= [[NSString alloc]initWithFormat:@"Life %i",level];
            [myLevel setText:scoreLabel];
            AudioServicesPlaySystemSound(sounds[0]);
            
            if (!contact) {
                contact = YES;
                score ++;
            }
            else {
                contact = NO; 
            }
        }
        //Flip the y velocity
        ballVelocity.y = 1 *abs(ballVelocity.y);
        ballVelocity.x = 1 *abs(ballVelocity.x);
        NSString* myNo = [[NSString alloc]initWithFormat:@"Embrace Inhale"];
        [myLabel setText:myNo];
        
    }
    else{
        NSString* myYes = [[NSString alloc]initWithFormat:@" "];
        [myLabel setText:myYes];
        score = 0;
    }
    //-------------LEVELS IN MY GAME : YES AND NO!---------------------
    if (scoreTime == 1000) {
        //Draw the letter
         yLetter = [[UIImageView alloc] initWithImage:
         [UIImage imageNamed:@"star1.png"]];
         
         CGSize yLetterSize = [yLetter.image size];
         
         [yLetter setFrame:CGRectMake(50.0, 60.0,
         yLetterSize.width, yLetterSize.height)];
         
         [self.view addSubview:yLetter];
         
    }
    if (scoreTime == 2000) {
        //Draw the letter
        nLetter = [[UIImageView alloc] initWithImage:
                   [UIImage imageNamed:@"star2.png"]];
        
        CGSize yLetterSize = [yLetter.image size];
        
        [nLetter setFrame:CGRectMake(50.0, 65.0,
                                     yLetterSize.width, yLetterSize.height)];
        
        [self.view addSubview:nLetter];
        
    }
    if (scoreTime == 3950) {
        //Draw the letter
        nLetter = [[UIImageView alloc] initWithImage:
                   [UIImage imageNamed:@"star3.png"]];
        
        CGSize yLetterSize = [yLetter.image size];
        
        [nLetter setFrame:CGRectMake(50.0, 65.0,
                                     yLetterSize.width, yLetterSize.height)];
        
        [self.view addSubview:nLetter];
        
    }
    
    //Check to see if TRIANGL is colliding with BALL
    if (CGRectIntersectsRect(triangl.frame, ball.frame)) {
        score++;
        if (score == 1) {
            scoreTime++;
            NSString* scoreLabel= [[NSString alloc]initWithFormat:@"| %i |",scoreTime];
            [myScore setText:scoreLabel];
            if (!contact) {
                contact = YES;
                score ++;
            }
            else {
                contact = NO;
            }
        }
        //Flip the y velocity
        trianglVelocity.y = 1 *abs(trianglVelocity.y);
        trianglVelocity.x = 1 *abs(trianglVelocity.x);
        //NSString* myNoTo = [[NSString alloc]initWithFormat:@"Create Chaos"];
        //[myLabelTo setText:myNoTo];
        
    }
    else{
        NSString* myYesTo = [[NSString alloc]initWithFormat:@" "];
        [myLabelTo setText:myYesTo];
        score = 0;
    }
    if ( level == -50)
    {
        // No more blocks, end the game
        [self endGameWithMessage:@"You are still very beautiful"];
    }
    if ( scoreTime == 4000)
    {
        // No more blocks, end the game
        [self winGameWithMessage:@"Now look at you, hot stuff"];
    }

}
-(void) endGameWithMessage:(NSString*) message
{
    // Call this method to end the game
    // Invalidate the timer
    [gameTimer invalidate];
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}
-(void) winGameWithMessage:(NSString*) message
{
    // Call this method to end the game
    // Invalidate the timer
    [gameTimer invalidate];
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OH OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)viewDidUnload
{
    [self setMyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end

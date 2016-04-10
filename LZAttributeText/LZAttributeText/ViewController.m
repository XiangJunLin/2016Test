//
//  ViewController.m
//  LZAttributeText
//
//  Created by comst on 16/4/10.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#define sourceString @"Hello World"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labe01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configForType:self.type];
    
}

/**
 *  @[@"NSFontAttributeName", @"NSForegroundColorAttributeName", @"NSBackgroundColorAttributeName", @"NSLigatureAttributeName", @"NSKernAttributeName", @"NSStrikethroughStyleAttributeName", @"NSStrikethroughColorAttributeName", @"NSUnderlineStyleAttributeName", @"NSUnderlineColorAttributeName", @"NSStrokeWidthAttributeName", @"NSStrokeColorAttributeName", @"NSShadowAttributeName", @"NSTextEffectAttributeName", @"NSBaselineOffsetAttributeName", @"NSObliquenessAttributeName", @"NSExpansionAttributeName", @"NSWritingDirectionAttributeName", @"NSVerticalGlyphFormAttributeName", @"NSLinkAttributeName", @"NSAttachmentAttributeName", @"NSParagraphStyleAttributeName"];
 *
 *  @param type <#type description#>
 */

- (void)ConfigFontNameType{
    //Courier
//    NSArray *fontFamilyArray = [UIFont familyNames];
//    NSLog(@"%@", fontFamilyArray);
//    NSArray *fontArray = [UIFont fontNamesForFamilyName:@"Courier"];
//    NSLog(@"%@", fontArray);
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier" size:15] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Zapfino" size:15] range:totalRange];
    self.label03.attributedText = attrStringM2;

}

- (void)configForeGroundColor{
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:totalRange];
    self.label03.attributedText = attrStringM2;
    
}

- (void)configBackgroundColor{
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSBackgroundColorAttributeName value:[UIColor blueColor] range:totalRange];
    self.label03.attributedText = attrStringM2;
}

- (void)configLigatureType{
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSLigatureAttributeName value:@(1) range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSLigatureAttributeName value:@(0) range:totalRange];
    self.label03.attributedText = attrStringM2;

}

- (void)configKernType{
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSKernAttributeName value:@(3) range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSKernAttributeName value:@(-3) range:totalRange];
    self.label03.attributedText = attrStringM2;

}

- (void)configStriketype{
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSStrikethroughStyleAttributeName value:@(3) range:totalRange];
    [attrStringM1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSStrikethroughStyleAttributeName   value:@(5) range:totalRange];
    [attrStringM2 addAttribute:NSStrikethroughColorAttributeName value:[UIColor greenColor] range:totalRange];
    self.label03.attributedText = attrStringM2;

}

- (void)configUnderLineType{
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleThick) range:totalRange];
    [attrStringM1 addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSUnderlineStyleAttributeName   value:@(NSUnderlineStyleSingle) range:totalRange];
    [attrStringM2 addAttribute:NSUnderlineColorAttributeName value:[UIColor greenColor] range:totalRange];
    self.label03.attributedText = attrStringM2;
}

- (void)configStrokeType{
 
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSStrokeWidthAttributeName value:@(3) range:totalRange];
    [attrStringM1 addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    [attrStringM2 addAttribute:NSStrokeWidthAttributeName   value:@(-3) range:totalRange];
    [attrStringM2 addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:totalRange];
    self.label03.attributedText = attrStringM2;

}

- (void)configShadowType{
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    NSShadow *shadow1 = [[NSShadow alloc] init];
    shadow1.shadowOffset = CGSizeMake(0, 5);
    shadow1.shadowColor = [UIColor redColor];
    shadow1.shadowBlurRadius = 5;
    
    [attrStringM1 addAttribute:NSShadowAttributeName value:shadow1 range:totalRange];
    
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSShadow *shadow2 = [[NSShadow alloc] init];
    shadow2.shadowOffset = CGSizeMake(5, 0);
    shadow2.shadowColor = [UIColor blueColor];
    shadow2.shadowBlurRadius = 3;
    [attrStringM2 addAttribute:NSShadowAttributeName   value:shadow2 range:totalRange];
    
    self.label03.attributedText = attrStringM2;

}

- (void)configTextEffect{
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    
    self.label03.attributedText = attrStringM2;

}

- (void)configBaselineOffset{
    self.labe01.backgroundColor = [UIColor lightGrayColor];
    self.label02.backgroundColor = [UIColor darkGrayColor];
    self.label03.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSBaselineOffsetAttributeName value:@(5) range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    [attrStringM2 addAttribute:NSBaselineOffsetAttributeName value:@(-3) range:totalRange];
   
    self.label03.attributedText = attrStringM2;

}

- (void)configObliqueness{
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSObliquenessAttributeName value:@(0.5) range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    [attrStringM2 addAttribute:NSObliquenessAttributeName value:@(0.2) range:totalRange];
    
    self.label03.attributedText = attrStringM2;

}

- (void)configExpansion{
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSExpansionAttributeName value:@(0.2) range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    [attrStringM2 addAttribute:NSExpansionAttributeName value:@(-0.5) range:totalRange];
    
    self.label03.attributedText = attrStringM2;

}

- (void)configWritingDirection{
    
    /**
     //@[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionEmbedding)]
     //@[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionOverride)]
     //@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionEmbedding)]
     //@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)]
     
     */
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSWritingDirectionAttributeName value:@[@(NSWritingDirectionLeftToRight |NSTextWritingDirectionEmbedding)] range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    [attrStringM2 addAttribute:NSWritingDirectionAttributeName value:@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionEmbedding)] range:totalRange];
    
    self.label03.attributedText = attrStringM2;

}

- (void)configAttachmentType{

    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    
    NSTextAttachment *attach1 = [[NSTextAttachment alloc] init];
    attach1.image = [UIImage imageNamed:@"panda"];
    attach1.bounds = CGRectMake(0, 0, 30, 30);
    
    NSAttributedString *attchString = [NSMutableAttributedString attributedStringWithAttachment:attach1];
    
    [attrStringM1 insertAttributedString:attchString atIndex:5];
    self.label02.attributedText = attrStringM1;
    
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    
    NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
    attach2.image = [UIImage imageNamed:@"panda"];
    attach2.bounds = CGRectMake(0, 0, 20, 20);
    
    NSAttributedString *attchString2 = [NSMutableAttributedString attributedStringWithAttachment:attach2];
    
    [attrStringM2 insertAttributedString:attchString2 atIndex:10];
    
    self.label03.attributedText = attrStringM2;
    
}

- (void)configParaGraphType{
    
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.lineBreakMode = NSLineBreakByTruncatingHead;
    
    
    NSMutableParagraphStyle *paraStyle02 = [[NSMutableParagraphStyle alloc] init];
    paraStyle02.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    NSMutableAttributedString *attrStringM1 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    NSRange totalRange = [sourceString rangeOfString:sourceString];
    [attrStringM1 addAttribute:NSParagraphStyleAttributeName value:paraStyle01 range:totalRange];
    self.label02.attributedText = attrStringM1;
    
    
    NSMutableAttributedString *attrStringM2 = [[NSMutableAttributedString alloc] initWithString:sourceString];
    [attrStringM2 addAttribute:NSParagraphStyleAttributeName value:paraStyle02 range:totalRange];
    
    self.label03.attributedText = attrStringM2;
}

- (void)configForType:(NSString *)type{
    if ([self.type isEqualToString:@"NSFontAttributeName"]) {
        
        [self ConfigFontNameType];
        
    }else if ([self.type isEqualToString:@"NSForegroundColorAttributeName"]){
        
        [self configForeGroundColor];
        
    }else if ([self.type isEqualToString:@"NSBackgroundColorAttributeName"]){
        
        [self configBackgroundColor];
        
    }else if ([self.type isEqualToString:@"NSLigatureAttributeName"]){
        
        [self configLigatureType];
        
    } else if ([self.type isEqualToString:@"NSKernAttributeName"]){
        
        [self configKernType];
        
    }else if ([self.type isEqualToString:@"NSStrikethroughStyleAttributeName"]){
        
        [self configStriketype];
        
    }else if ([self.type isEqualToString:@"NSStrikethroughColorAttributeName"]){
        
        [self configStriketype];
        
    }else if ([self.type isEqualToString:@"NSUnderlineStyleAttributeName"]){
        
        [self configUnderLineType];
        
    }else if ([self.type isEqualToString:@"NSUnderlineColorAttributeName"]){
        
        [self configUnderLineType];
        
    }else if ([self.type isEqualToString:@"NSStrokeWidthAttributeName"]){
        
        [self configStrokeType];
        
    }else if ([self.type isEqualToString:@"NSStrokeColorAttributeName"]){
        
        [self configStrokeType];
        
    }else if ([self.type isEqualToString:@"NSShadowAttributeName"]){
        
        [self configShadowType];
        
    }else if ([self.type isEqualToString:@"NSTextEffectAttributeName"]){
        
        [self configTextEffect];
        
    }else if ([self.type isEqualToString:@"NSBaselineOffsetAttributeName"]){
        
        [self configBaselineOffset];
        
    }else if ([self.type isEqualToString:@"NSObliquenessAttributeName"]){
        
        [self configObliqueness];
        
    }else if ([self.type isEqualToString:@"NSExpansionAttributeName"]){
        
        [self configExpansion];
        
    }else if ([self.type isEqualToString:@"NSWritingDirectionAttributeName"]){
        
        [self configWritingDirection];
        
    }else if ([self.type isEqualToString:@"NSVerticalGlyphFormAttributeName"]){
        
    }else if ([self.type isEqualToString:@"NSLinkAttributeName"]){
        
    }else if ([self.type isEqualToString:@"NSAttachmentAttributeName"]){
        
        [self configAttachmentType];
        
    }else{
        
        [self configParaGraphType];
        
    }
}

/**
 *   Copperplate,
 "Heiti SC",
 "Iowan Old Style",
 "Kohinoor Telugu",
 Thonburi,
 "Heiti TC",
 "Courier New",
 "Gill Sans",
 "Apple SD Gothic Neo",
 "Marker Felt",
 "Avenir Next Condensed",
 "Tamil Sangam MN",
 "Helvetica Neue",
 "Gurmukhi MN",
 "Times New Roman",
 Georgia,
 "Apple Color Emoji",
 "Arial Rounded MT Bold",
 Kailasa,
 "Kohinoor Devanagari",
 "Kohinoor Bangla",
 "Chalkboard SE",
 "Sinhala Sangam MN",
 "PingFang TC",
 "Gujarati Sangam MN",
 Damascus,
 Noteworthy,
 "Geeza Pro",
 Avenir,
 "Academy Engraved LET",
 Mishafi,
 Futura,
 Farah,
 "Kannada Sangam MN",
 "Arial Hebrew",
 Arial,
 "Party LET",
 Chalkduster,
 "Hoefler Text",
 Optima,
 Palatino,
 "Lao Sangam MN",
 "Malayalam Sangam MN",
 "Al Nile",
 "Bradley Hand",
 "PingFang HK",
 "Trebuchet MS",
 Helvetica,
 Courier,
 Cochin,
 "Hiragino Mincho ProN",
 "Devanagari Sangam MN",
 "Oriya Sangam MN",
 "Snell Roundhand",
 "Zapf Dingbats",
 "Bodoni 72",
 Verdana,
 "American Typewriter",
 "Avenir Next",
 Baskerville,
 "Khmer Sangam MN",
 Didot,
 "Savoye LET",
 "Bodoni Ornaments",
 Symbol,
 Menlo,
 "Bodoni 72 Smallcaps",
 Papyrus,
 "Hiragino Sans",
 "PingFang SC",
 "Euphemia UCAS",
 "Telugu Sangam MN",
 "Bangla Sangam MN",
 Zapfino,
 "Bodoni 72 Oldstyle"
 */

@end

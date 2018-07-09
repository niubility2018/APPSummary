//
//  LicensePlateTextField.m
//  LicensePlateTextFieldDemo
//
//  Created by DBC on 2018/7/4.
//  Copyright © 2018年 DBC. All rights reserved.
//

#import "LicensePlateTextField.h"
#import "ProvinceSampleKeyboardView.h"

#define kMaxTextLength   8


@interface LicensePlateContent : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger index;
@end

@implementation LicensePlateContent

@end

@interface LicensePlateTextField ()

@end

@implementation LicensePlateTextField{
    UIColor *_borderColor; // 边框颜色
    UIColor *_selectedColor;
    CGFloat _borderWidth; // 边框线条宽度
    CGFloat _cornerRadius; // 圆角半径
    UIColor *_pointColor; // 点的颜色
    BOOL _isSecureTextEntry; // 是否是安全输入模式
    
    NSInteger _curentIndex; // x选择样式的下标
    
    NSMutableArray *_contentArray; // 文本内容容器
    
    UIColor *_placeholderColor; // 新能源提示字体颜色
    
    CGFloat _pointGap; // 点位置的间距
    CGFloat _normalGap; // 普通的间距
    CGFloat _lastGap; // 新能源 前面的间距
}

- (void)dealloc
{
    
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self _init];
}

-(void)_init{
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:14];
    _borderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    _selectedColor = [UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1];
    _placeholderColor = [UIColor grayColor];
    _pointColor = [UIColor redColor];
    _borderWidth = 1;
    _curentIndex = -1; // 初始值
    _cornerRadius = 2;
    _contentArray = [NSMutableArray arrayWithCapacity:kMaxTextLength];
    for (int i = 0; i < kMaxTextLength; i++) {
        LicensePlateContent *content = [[LicensePlateContent alloc] init];
        content.text = @"";
        content.index = i;
        [_contentArray addObject:content];
    }
    
    _pointGap = 14;
    _normalGap = 2;
    _lastGap = 3;
}

-(void)setCurentIndex:(NSInteger)curentIndex{
    _curentIndex = curentIndex;
    
    [self setNeedsDisplay];
}

-(NSString *)text{
    NSMutableString *innerText = [NSMutableString string];
    for (LicensePlateContent *content in _contentArray) {
        [innerText appendString:content.text];
    }
    return innerText;
}

-(NSString *)numString{
    NSMutableString *numStr = [NSMutableString string];
    for (int i = 1; i < _contentArray.count; i++) {
        LicensePlateContent *content = _contentArray[i];
        [numStr appendString:content.text];
    }
    return numStr;
}

-(NSString *)sampleProvince{
    LicensePlateContent *content = _contentArray[0];
    return content.text;
}


-(void)setText:(NSString *)text{
    if (text == nil) {
        text = @"";
    }
    
    for (LicensePlateContent *content in _contentArray) {
        content.text = @"";
    }
    
    for (int i = 0; i < text.length; i++) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        if (i < _contentArray.count) {
            LicensePlateContent *content = _contentArray[i];
            content.text = word;
        }
    }
    [self setNeedsDisplay];
}

- (BOOL)hasText{
    return self.text.length>0;
}
- (void)insertText:(NSString *)text{
    if (text.length > 1) {
        return;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self resignFirstResponder];
        _curentIndex = -1;// 恢复初始值
        return;
    }
    if (_curentIndex >= kMaxTextLength) {
        _curentIndex = -1;// 恢复初始值
        [self resignFirstResponder];
        return;
    }
    
    if (_curentIndex == 1) {
        if (![self firstCharacterCanInputString:text]) {
            return;
        }
    } else if (_curentIndex > 1) {
        if (![self canInputWithString:text]) {
            return;
        }
    }
    
    LicensePlateContent *content = _contentArray[_curentIndex];
    content.text = [text uppercaseString];
    _curentIndex ++;
    if (_curentIndex >= kMaxTextLength-1) {
        _curentIndex = -1;// 恢复初始值
        [self resignFirstResponder];
    }
    
    [self setNeedsDisplay];
}
- (void)deleteBackward{
    if (_curentIndex < 0) {
        return;
    }
    LicensePlateContent *content = _contentArray[_curentIndex];
    if (content.text.length == 0) {
        _curentIndex --;
        if (_curentIndex >=0) {
            LicensePlateContent *nextContent = _contentArray[_curentIndex];
            nextContent.text = @"";
        }
        _curentIndex = MAX(_curentIndex, 0);
        
        if (_curentIndex == 0) {
            [self showProvinceKeyboard];
        }
    }
    content.text = @"";
    
    [self setNeedsDisplay];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    for (int i = 0; i< kMaxTextLength; i++) {
        CGRect rect = [self subRectFrom:self.bounds widthIndex:i];
        if (CGRectContainsPoint(rect, p)) {
            _curentIndex = i;
            [self setNeedsDisplay];
            break;
        }
    }
    if (_curentIndex == 0) {
        [self showProvinceKeyboard];
    } else if(_curentIndex >0 && _curentIndex < kMaxTextLength){
        if (![self isFirstResponder]) {
            [self becomeFirstResponder];
        }
    } else {
        
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(BOOL)becomeFirstResponder{
    if (_curentIndex == 0) {
        [self showProvinceKeyboard];
        return NO;
    } else {
        [ProvinceSampleKeyboardView hideWithAnimation:NO];
        return [super becomeFirstResponder];
    }
}

- (BOOL)resignFirstResponder{
    if (self.isFirstResponder) {
        // textField did end edit
    }
    [ProvinceSampleKeyboardView hideWithAnimation:NO];
    _curentIndex = -1; // 恢复初始值
    [self setNeedsDisplay];
    return [super resignFirstResponder];
}

- (BOOL)canResignFirstResponder{
    return YES;
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeASCIICapable;
}
// 自动校验关闭
-(UITextAutocorrectionType)autocorrectionType{
    return UITextAutocorrectionTypeNo;
}
// 显示省份简称键盘
-(void)showProvinceKeyboard{
    [self resignFirstResponder];
    _curentIndex = 0;
    ProvinceSampleKeyboardView *keyboard = [ProvinceSampleKeyboardView showWidthAnimation:YES];
    keyboard.block = ^(id obj) {
        NSLog(@"%@", obj);
        [ProvinceSampleKeyboardView hideWithAnimation:YES];
        LicensePlateContent *content = self->_contentArray[self->_curentIndex];
        content.text = obj;
        self->_curentIndex++;
        [self becomeFirstResponder];
        [self setNeedsDisplay];
    };
    keyboard.deleteBlock = ^{
        NSLog(@"delete");
        LicensePlateContent *content = self->_contentArray[self->_curentIndex];
        content.text = @"";
        [self setNeedsDisplay];
    };
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self drawGrid:rect];
    
    [self drawText:rect];
}

-(void)drawGrid:(CGRect)rect{
    
    for (int i = 0; i < kMaxTextLength; i++) {
        CGRect gridRect = [self subRectFrom:rect widthIndex:i];
        [self drawBorder:gridRect widthIndex:i];
        if (i == 1) {
            CGFloat d2 = _pointGap;
            CGFloat pointRadius = 4.0;
            CGFloat x = gridRect.origin.x+gridRect.size.width+(d2-pointRadius)/2.0;
            CGFloat y = (rect.size.height - pointRadius)/2.0;
            CGRect pointRect = CGRectMake(x, y, pointRadius, pointRadius);
            [self drawPoint:pointRect];
        }
    }
}
// 画间隔点
-(void)drawPoint:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, _pointColor.CGColor);
    
    CGContextFillEllipseInRect(context, rect);
    
    CGContextRestoreGState(context);
}

// 画边框
-(void)drawBorder:(CGRect)rect widthIndex:(NSInteger)index{
    CGFloat cornerRadius = _cornerRadius;
    CGFloat originX = rect.origin.x;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 画 框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (_curentIndex == index) {
        CGContextSetStrokeColorWithColor(context, _selectedColor.CGColor);
    }else {
        CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    }
    CGContextSetLineWidth(context, _borderWidth);
    
    // 新能源标示 样式
    if (index == kMaxTextLength - 1){
        LicensePlateContent *content = _contentArray[index];
        if (content.text.length == 0 && _curentIndex != index) {
            CGFloat lengths[] = {2,2};
            CGContextSetLineDash(context, 0, lengths, 2);
            
            CGContextSetStrokeColorWithColor(context, _placeholderColor.CGColor);
        }
    }
    
    // 上边
    CGFloat x = cornerRadius+originX;
    CGFloat y = 0;
    CGContextMoveToPoint(context, x+_borderWidth/2.0, y+_borderWidth/2.0);
    
    x = width-cornerRadius+originX;
    y = 0;
    CGContextAddLineToPoint(context, x-_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 右上角圆弧
    CGFloat cpx = width-_borderWidth/2.0+originX;
    CGFloat cpy = 0+_borderWidth/2.0;
    x = width+originX;
    y = cornerRadius;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x-_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 右边
    x = width+originX;
    y = height-cornerRadius;
    CGContextAddLineToPoint(context, x-_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 右下角圆弧
    cpx = width-_borderWidth/2.0+originX;
    cpy = height-_borderWidth/2.0;
    x = width-cornerRadius+originX;
    y = height;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x-_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 下边
    x = cornerRadius+originX;
    y = height;
    CGContextAddLineToPoint(context, x+_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 左下圆角
    cpx = 0+_borderWidth/2.0+originX;
    cpy = height-_borderWidth/2.0;
    x = 0+originX;
    y = height-cornerRadius;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x+_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 左边
    x = 0+originX;
    y = cornerRadius;
    CGContextAddLineToPoint(context, x+_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 左上角圆弧
    cpx = 0+_borderWidth/2.0+originX;
    cpy = 0+_borderWidth/2.0;
    x = cornerRadius+originX;
    y = 0;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x+_borderWidth/2.0, y+_borderWidth/2.0);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}
// 文字
-(void)drawText:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    for (int i = 0; i < _contentArray.count; i++) {
        LicensePlateContent *content = _contentArray[i];
        NSString *word = content.text;
        if (word.length == 0) {
            
            // 新能源标示 样式
            if (i == kMaxTextLength - 1){
                LicensePlateContent *content = _contentArray[i];
                if (content.text.length == 0 && _curentIndex != i) {
                    CGRect subRect = [self subRectFrom:rect widthIndex:i];
                    CGFloat itemWidth = subRect.size.width;
                    
                    CGFloat centerX = subRect.size.width/2.0+subRect.origin.x;
                    CGFloat centerY = subRect.size.height/2.0;
                    // 十字
                    CGFloat lineWidth = 10;
                    CGFloat lx = (subRect.size.width - lineWidth)/2.0+subRect.origin.x;
                    
                    CGFloat ly = centerY-lineWidth;
                    CGContextSetStrokeColorWithColor(context, _placeholderColor.CGColor);
                    CGContextSetLineWidth(context, _borderWidth);
                    // 横
                    CGContextMoveToPoint(context, lx, ly);
                    CGContextAddLineToPoint(context, lx+lineWidth, ly);
                    CGContextStrokePath(context);
                    // 竖
                    CGContextMoveToPoint(context, centerX, ly-lineWidth/2.0);
                    CGContextAddLineToPoint(context, centerX, ly+lineWidth/2.0);
                    CGContextStrokePath(context);
                    
                    NSString *text = @"新能源";
                    CGFloat fontSize = 10;
                    if (subRect.size.width<=27) {
                        fontSize = 7;
                    } else if (subRect.size.width < 36){
                        fontSize = 9;
                    }
                    UIFont *noticeFont = [UIFont systemFontOfSize:fontSize];
                    CGSize textSize = [self sizeForText:text font:noticeFont];
                    CGFloat y = ly + lineWidth;
                    
                    CGFloat x = subRect.origin.x+(itemWidth-textSize.width)/2.0;
                    
                    CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
                    
                    [text drawInRect:textRect withAttributes:@{NSFontAttributeName:noticeFont,NSForegroundColorAttributeName:_placeholderColor}];
                }
            }
            continue;
        }
        
        
        
        CGRect subRect = [self subRectFrom:rect widthIndex:i];
        CGFloat itemWidth = subRect.size.width;
        
        CGSize textSize = [self sizeForText:word];
        CGFloat y = (subRect.size.height-textSize.height)/2.0;
        
        CGFloat x = subRect.origin.x+(itemWidth-textSize.width)/2.0;
        
        CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
        [word drawInRect:textRect withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor}];
    }
    
    CGContextRestoreGState(context);
}

// 上下居中
-(CGSize)sizeForText:(NSString *)txt{
    CGSize size = [txt sizeWithAttributes:@{NSFontAttributeName:_font}];
    return CGSizeMake(size.width, size.height);
}

// 上下居中
-(CGSize)sizeForText:(NSString *)txt font:(UIFont *)font{
    CGSize size = [txt sizeWithAttributes:@{NSFontAttributeName:font}];
    return CGSizeMake(size.width, size.height);
}

-(CGRect)subRectFrom:(CGRect)rect widthIndex:(NSInteger)index{
    
    CGFloat d = _normalGap;
    CGFloat d1 = _lastGap;
    CGFloat d2 = _pointGap;
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGFloat itemWidth = (width-d*5-d1-d2)/8.0;
    
    CGRect gridRect;
    if (index == 0) {
        gridRect = CGRectMake(0, 0, itemWidth, height);
    } else if(index == 1){
        gridRect = CGRectMake(itemWidth+d, 0, itemWidth, height);
    } else if(index == 2){
        gridRect = CGRectMake(itemWidth*2+d+d2, 0, itemWidth, height);
    } else if(index == 3){
        gridRect = CGRectMake(itemWidth*3+d*2+d2, 0, itemWidth, height);
    } else if(index == 4){
        gridRect = CGRectMake(itemWidth*4+d*3+d2, 0, itemWidth, height);
    } else if(index == 5){
        gridRect = CGRectMake(itemWidth*5+d*4+d2, 0, itemWidth, height);
    } else if(index == 6){
        gridRect = CGRectMake(itemWidth*6+d*5+d2, 0, itemWidth, height);
    } else {
        gridRect = CGRectMake(itemWidth*7+d*5+d2+d1, 0, itemWidth, height);
    }
    return gridRect;
}



///  字符串输入限制

-(BOOL)firstCharacterCanInputString:(NSString *)string{
    //当前输入的字符
    unichar single = [string characterAtIndex:0];
    
    // 不能输入a-z A-Z以外的字符
    if (!((single >= 'a' && single <= 'z') || (single >= 'A' && single <= 'Z')))
    {
        return NO;
    }
    return YES;
}

-(BOOL)canInputWithString:(NSString *)string{
    //当前输入的字符
    unichar single = [string characterAtIndex:0];
    
    // 不能输入.0-9 a-z A-Z以外的字符
    if (!((single >= '0' && single <= '9') || (single >= 'a' && single <= 'z') || (single >= 'A' && single <= 'Z')))
    {
        return NO;
    }
    return YES;
}

@end

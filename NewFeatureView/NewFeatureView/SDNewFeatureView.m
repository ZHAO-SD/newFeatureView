






#import "SDNewFeatureView.h"

@interface SDNewFeatureView()<UIScrollViewDelegate>

/** 背景 */
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
/** 指示器 */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 立即体验 */
@property (nonatomic, strong) UIButton *enterBtn;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation SDNewFeatureView


#pragma mark - 显示新特性
+(void)showNewFeatureView:(NSArray *)dataSource view:(UIView *)superView{
    
    SDNewFeatureView *view = [[SDNewFeatureView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.dataSource = dataSource;
    [superView addSubview:view];
}

-(UIScrollView *)backgroundScrollView{
    if (_backgroundScrollView == nil) {
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _backgroundScrollView.bounces = NO;
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.delegate = self;
    }
    return _backgroundScrollView;
}

-(UIButton *)enterBtn{
    if (_enterBtn == nil) {
        _enterBtn = [[UIButton alloc] init];
        _enterBtn.layer.cornerRadius = 5;
        _enterBtn.layer.masksToBounds = YES;
        _enterBtn.layer.borderColor = [UIColor redColor].CGColor;
        _enterBtn.layer.borderWidth = 1;
        [_enterBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat w = 120;
        CGFloat h = 30;
        CGFloat x = (self.bounds.size.width - w) * 0.5;
        CGFloat y = self.bounds.size.height * 0.8;
        _enterBtn.frame = CGRectMake(x, y, w, h);
        
    }
    return _enterBtn;
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
        _pageControl.userInteractionEnabled = NO;
        CGFloat w = 100;
        CGFloat h = 30;
        CGFloat x = (self.bounds.size.width - w) * 0.5;
        CGFloat y = self.bounds.size.height * 0.9;
        _pageControl.frame = CGRectMake(x, y, w, h);
    }
    return _pageControl;
}

#pragma mark - 立即体验 方法
-(void)enterBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:1 animations:^{
        
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
        
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger page = offsetX / self.bounds.size.width;
    
    self.pageControl.currentPage = page;
}


-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    //添加背景
    [self addSubview:self.backgroundScrollView];
    
    CGFloat width = self.backgroundScrollView.bounds.size.width;
    CGFloat height = self.backgroundScrollView.bounds.size.height;
    
    //添加imgView
    for (NSInteger i = 0; i < dataSource.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.backgroundScrollView.bounds];
        imgView.frame = CGRectMake(width*i, 0, width, height);
        imgView.userInteractionEnabled = YES;
        
        //判断数据源中的类型
        if ([dataSource.firstObject isKindOfClass:[NSString class]]) {
            
            if ([dataSource.firstObject hasPrefix:@"http"]) {
                //网络图片
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataSource[i]]]];
                    // 图片下载完成之后,回到主线程更新UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imgView.image = image;
                    });
                });
                
                
            }else{
                //本地图片名称
                imgView.image = [UIImage imageNamed:dataSource[i]];
            }
            
        }else if([dataSource.firstObject isKindOfClass:[UIImage class]]){
                //图片
            imgView.image = dataSource[i];
        }else{
            
            imgView.image = nil;
        }
        
        //在最后一张,添加按钮
        if (i == dataSource.count - 1) {
            [imgView addSubview:self.enterBtn];
        }
        
        
        [self.backgroundScrollView addSubview:imgView];
    }
    
    //添加指示器
    self.pageControl.numberOfPages = dataSource.count;
    [self addSubview:self.pageControl];
    
    self.backgroundScrollView.contentSize = CGSizeMake(self.bounds.size.width*dataSource.count, self.bounds.size.height);
    
}

@end

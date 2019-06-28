






#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDNewFeatureView : UIView

/** 数据源(可以是图片url 图片名称 或 图片) */
+(void)showNewFeatureView:(NSArray *)dataSource view:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END

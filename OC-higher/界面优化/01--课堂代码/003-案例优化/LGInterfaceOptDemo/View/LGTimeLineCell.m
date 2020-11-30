//
//  LGTimeLineCell.m
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import "LGTimeLineCell.h"
#import "UIButton+WebCache.h"
#import "LGTimeLineModel.h"
#import "Masonry.h"
#import "LGTimeLineCellLayout.h"
#import "UIImage+cornerRadious.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CONTENT_BTN_TAG_CONST 10000

NSString *ResuseID = @"LGTimeLineCell";

@interface LGTimeLineCell ()

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableArray *contentImageBtns;
@property (nonatomic, strong) UIView *seperatorView;


@property (nonatomic, strong) UIButton *expandBtn;
@property (nonatomic, assign) BOOL isExpandedNow;

@property (nonatomic, strong) LGTimeLineCellLayout *layout;

@end

@implementation LGTimeLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentImageBtns = [NSMutableArray array];
        [self setupUI];
        self.isExpandedNow = YES;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.iconButton];
    
    [self.contentView addSubview:self.nameLabel];
  
    [self.contentView addSubview:self.contentLabel];

    for (int i = 0; i < 9; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = CONTENT_BTN_TAG_CONST + i;
        [btn addTarget:self action:@selector(contentImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.contentImageBtns addObject:btn];
    }
   
    [self.contentView addSubview:self.expandBtn];
   
    [self.contentView addSubview:self.seperatorView];
}

- (void)configureLayout:(LGTimeLineCellLayout *)layout{
    
    _layout = layout;
    
    self.iconButton.frame = layout.iconRect;
    
    
    //圆角的处理：主线程当中
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:layout.timeLineModel.iconUrl] forState:UIControlStateNormal];
    
    self.iconButton.layer.cornerRadius = self.iconButton.bounds.size.width/2;
    self.iconButton.layer.masksToBounds= YES;

    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:layout.timeLineModel.iconUrl] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        [self.iconButton setImage:[image cornerRadius:self.iconButton.bounds.size.width/ 2.0 size:self.iconButton.bounds.size] forState:UIControlStateNormal];

    }];
           
    
    self.nameLabel.text = layout.timeLineModel.name;
    self.nameLabel.frame = layout.nameRect;
       
      
    self.contentLabel.text = layout.timeLineModel.msgContent;
    self.contentLabel.frame = layout.contentRect;
       
      
    self.expandBtn.frame = layout.expandRect;
    self.expandBtn.hidden = layout.expandHidden;
    if (layout.timeLineModel.isExpand) {
        [self.expandBtn setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        [self.expandBtn setTitle:@"全文" forState:UIControlStateNormal];
    }
       
    self.seperatorView.frame = layout.seperatorViewRect;
       
    for (UIButton *btn in self.contentImageBtns) {
       btn.frame = CGRectZero;
    }
    
    for (int i = 0; i < layout.imageRects.count; i++) {
       CGRect imageRect = [layout.imageRects[i] CGRectValue];
       UIButton *btn = self.contentImageBtns[i];
       btn.frame = imageRect;
        NSString *imageStr = layout.timeLineModel.contentImages[i];
        [btn sd_setImageWithURL:[NSURL URLWithString:imageStr] forState:UIControlStateNormal];
    }
}


- (void)expandBtnClick:(UIButton *)btn {
    if (self.expandBlock) {
        self.expandBlock(self.layout.timeLineModel.expand);
    }
}

- (CGFloat)calculateRowHeightWithContent:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 26, 0) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}



#pragma mark -- Getter and Setter

- (UIButton *)iconButton{
    if (!_iconButton) {
        _iconButton = [[UIButton alloc] init];
    }
    return _iconButton;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    }
    return _contentLabel;
}

- (UIButton *)expandBtn{
    if (!_expandBtn) {
       _expandBtn = [[UIButton alloc] init];
           [_expandBtn setTitle:@"全文" forState:UIControlStateNormal];
           _expandBtn.titleLabel.font = [UIFont systemFontOfSize:14];
           [_expandBtn setTitleColor:[UIColor colorWithRed:118/255.0 green:118/255.0 blue:253/255.0 alpha:1] forState:UIControlStateNormal];
           [_expandBtn addTarget:self action:@selector(expandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

- (UIView *)seperatorView{
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] init];
        _seperatorView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _seperatorView;
}

@end

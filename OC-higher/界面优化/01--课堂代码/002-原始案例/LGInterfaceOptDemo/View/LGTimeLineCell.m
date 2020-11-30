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

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CONTENT_BTN_TAG_CONST 10000

NSString *ResuseID = @"LGTimeLineCell";

@interface LGTimeLineCell ()

@property (nonatomic, weak) UIButton *iconButton;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableArray *contentImageBtns;
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIButton *expandBtn;
@property (nonatomic, assign) BOOL isExpandedNow;

@property (nonatomic, strong) LGTimeLineModel *timeLineModel;

@property (nonatomic, strong) UIView *seperatorView;

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

- (void)configureTimeLineCell:(LGTimeLineModel *)timeLineModel{
    
   _timeLineModel = timeLineModel;
      
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:timeLineModel.iconUrl] forState:UIControlStateNormal];
      
    self.nameLabel.text = timeLineModel.name;
    self.contentLabel.text = timeLineModel.msgContent;
         
     if ([self calculateRowHeightWithContent:timeLineModel.msgContent] < 110) {
         self.expandBtn.hidden = YES;
         [self.expandBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.contentLabel);
              make.top.equalTo(self.contentLabel.mas_bottom);
              make.width.equalTo(@30);
              make.height.equalTo(@0.01);
         }];
     } else {
         self.expandBtn.hidden = NO;
         [self.expandBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.contentLabel);
             make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
             make.width.equalTo(@30);
             make.height.equalTo(@20);
         }];
     }

     if (timeLineModel.isExpand != self.isExpandedNow) {
         self.isExpandedNow = timeLineModel.isExpand;
         if (self.isExpandedNow) {
             [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(self.iconButton);
                 make.right.equalTo(self).offset(-16);
                 make.top.equalTo(self.iconButton.mas_bottom).offset(10);
             }];
             [self.expandBtn setTitle:@"收起" forState:UIControlStateNormal];
         } else {
             [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_lessThanOrEqualTo(110);
             }];
             [self.expandBtn setTitle:@"全文" forState:UIControlStateNormal];
         }
     }
      
         for (UIButton *btn in self.contentImageBtns) {
             [btn removeFromSuperview];
         }
         [self.contentImageBtns removeAllObjects];
         if (timeLineModel.contentImages.count == 0) {
            [self.seperatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(self);
                 make.right.equalTo(self);
                 make.height.equalTo(@15);
                 make.top.equalTo(self.expandBtn.mas_bottom).offset(10);
            }];
         } else if (timeLineModel.contentImages.count == 1) {
             UIButton *contentImageBtn = [[UIButton alloc] init];
             [self.contentView addSubview:contentImageBtn];
             [contentImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(self).offset(11);
                 make.top.equalTo(self.expandBtn.mas_bottom).offset(10);
                 make.width.equalTo(@250);
                 make.height.equalTo(@150);
             }];
             [self.contentImageBtns addObject:contentImageBtn];
         } else if (timeLineModel.contentImages.count == 2 || timeLineModel.contentImages.count == 3) {
             for (int i = 0; i < timeLineModel.contentImages.count; i++) {
                 UIButton *contentImageBtn = [[UIButton alloc] init];
                 [self.contentView addSubview:contentImageBtn];
                 [contentImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.left.equalTo(self).offset(11 + i * (10 + 90));
                     make.top.equalTo(self.expandBtn.mas_bottom).offset(10);
                     make.width.equalTo(@90);
                     make.height.equalTo(@90);
                 }];
                 [self.contentImageBtns addObject:contentImageBtn];
             }
         } else if (timeLineModel.contentImages.count == 4) {
             for (int i = 0; i < 2; i++) {
                 for (int j = 0; j < 2; j++) {
                     UIButton *contentImageBtn = [[UIButton alloc] init];
                     [self.contentView addSubview:contentImageBtn];
                     [contentImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                         make.left.equalTo(self).offset(11 + j * (10 + 90));
                         make.top.equalTo(self.expandBtn.mas_bottom).offset(10 + i * (10 + 90));
                         make.width.equalTo(@90);
                         make.height.equalTo(@90);
                     }];
                     [self.contentImageBtns addObject:contentImageBtn];
                 }
             }
         } else if (timeLineModel.contentImages.count == 5 || timeLineModel.contentImages.count == 6 || timeLineModel.contentImages.count == 7 || timeLineModel.contentImages.count == 8 || timeLineModel.contentImages.count == 9) {
             for (int i = 0; i < timeLineModel.contentImages.count; i++) {
                     UIButton *contentImageBtn = [[UIButton alloc] init];
                     [self.contentView addSubview:contentImageBtn];
                     [contentImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                         make.left.equalTo(self).offset(11 + (i % 3) * (10 + 90));
                         make.top.equalTo(self.expandBtn.mas_bottom).offset(10 + (i / 3) * (10 + 90));
                         make.width.equalTo(@90);
                         make.height.equalTo(@90);
                     }];
                     [self.contentImageBtns addObject:contentImageBtn];
             }
         }

         if (self.contentImageBtns.count > 0) {
             for (int i = 0; i < self.contentImageBtns.count; i++) {
                 UIButton *btn = self.contentImageBtns[i];
                 btn.tag = CONTENT_BTN_TAG_CONST + i;
                 [btn addTarget:self action:@selector(contentImageClick:) forControlEvents:UIControlEventTouchUpInside];
                 NSString *imageStr = timeLineModel.contentImages[i];
                 [btn sd_setImageWithURL:[NSURL URLWithString:imageStr] forState:UIControlStateNormal];


                 if (i == self.contentImageBtns.count - 1) {
                     [self.seperatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                          make.left.equalTo(self);
                          make.right.equalTo(self);
                          make.height.equalTo(@15);
                          make.top.equalTo(btn.mas_bottom).offset(10);
                     }];
                 }
             }
         }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        self.contentImageBtns = [NSMutableArray array];
        self.isExpandedNow = YES;
    }
    return self;
}

- (void)setupUI {
    UIButton *headIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
    //告诉layer将位于它之下的layer都遮盖住
    headIconBtn.layer.masksToBounds = YES;
    //设置layer的圆角,刚好是自身宽度的一半，这样就成了圆形
    headIconBtn.layer.cornerRadius = headIconBtn.bounds.size.width * 0.5;
    [self.contentView addSubview:headIconBtn];
    self.iconButton = headIconBtn;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headIconBtn.mas_right).offset(11);
        make.top.equalTo(self).offset(17);
    }];
    
//    UIImageView *sexIconView = [[UIImageView alloc] init];
//    [self.contentView addSubview:sexIconView];
//    self.sexIconView = sexIconView;
//    [sexIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headIconBtn.mas_right).offset(9);
//        make.top.equalTo(nameLabel.mas_bottom).offset(6);
//        make.width.height.equalTo(@12);
//    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headIconBtn);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(headIconBtn.mas_bottom).offset(10);
    }];
    
    UIButton *expandBtn = [[UIButton alloc] init];
    [expandBtn setTitle:@"全文" forState:UIControlStateNormal];
    expandBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [expandBtn setTitleColor:[UIColor colorWithRed:118/255.0 green:118/255.0 blue:253/255.0 alpha:1] forState:UIControlStateNormal];
    [expandBtn addTarget:self action:@selector(expandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:expandBtn];
    self.expandBtn = expandBtn;
    [expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel);
        make.top.equalTo(contentLabel.mas_bottom).offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
        
    UIView *seperatorView = [[UIView alloc] init];
    seperatorView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.contentView addSubview:seperatorView];
    self.seperatorView = seperatorView;
    [seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@15);
        make.top.equalTo(expandBtn.mas_bottom).offset(10);
    }];
    
    self.contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 26;
}

- (void)expandBtnClick:(UIButton *)btn {
    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
    }
}

- (CGFloat)calculateRowHeightWithContent:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 26, 0) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

- (void)contentImageClick:(UIButton *)btn {
    if (self.previewPhotosBlock) {
        self.previewPhotosBlock(_timeLineModel.contentImages,(int)(btn.tag - CONTENT_BTN_TAG_CONST));
    }
    
}

@end

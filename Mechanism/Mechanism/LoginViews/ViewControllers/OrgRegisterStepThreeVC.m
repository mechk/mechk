//
//  OrgRegisterStepThreeVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgRegisterStepThreeVC.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"
#import "PhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Login.h"
#import "OrgRegisterStepFourVC.h"
#import <CoreLocation/CoreLocation.h>

@interface OrgRegisterStepThreeVC () <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoCollectionViewCellDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *logoButton;
@property (nonatomic, strong) UILabel *logoLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *maskButton;

@property (nonatomic, strong) UIImage *logoImage;
@property (nonatomic, strong) NSMutableArray *orgImageArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) SelectImageType selectImageType;

@property (nonatomic, strong) NSMutableArray *resourceList;
@property (nonatomic, copy) NSString *OrgLogoStr;

@property (nonatomic, strong) CLLocationManager *locationManager; // 定位

@end

@implementation OrgRegisterStepThreeVC {
    SBJsonParser * parser;
}

static NSString *const PHOTO_COLLECTIONCELL_ID = @"Image_cell_id";

- (UIButton *)logoButton {
    if (!_logoButton) {
        _logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoButton.layer.cornerRadius = KWIDTH(75);
        _logoButton.layer.masksToBounds = YES;
        [_logoButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Logo"] forState:UIControlStateNormal];
        [_logoButton addTarget:self action:@selector(logoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logoButton];
        [_logoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(KWIDTH(150));
            make.width.offset(KWIDTH(150));
            make.centerX.offset(0);
            make.top.offset(KHEIGHT(40));
        }];
    }
    return _logoButton;
}

- (void)logoButtonAction:(UIButton *)sender {
    self.selectImageType = SelectImageTypeLogo;
    [self addHead];
}

- (UILabel *)logoLabel {
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc] init];
        _logoLabel.text = @"机构LOGO";
        _logoLabel.font = [UIFont systemFontOfSize:15];
        _logoLabel.textColor = [CommonTool colorWithHexString:@"#4a4a4a"];
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_logoLabel];
        
        __weak typeof(self) weakSelf = self;
        [_logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.logoButton.mas_bottom).offset(KHEIGHT(20));
            make.centerX.offset(0);
        }];
    }
    return _logoLabel;
} 

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _nameTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _nameTextField.delegate = self;
        _nameTextField.font = [UIFont systemFontOfSize:KWIDTH(32)];
//        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _nameTextField.placeholder = @"请输入机构名称";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(35), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_Name"]];
        [leftView addSubview:phoneImageView];
        
        _nameTextField.leftView = leftView;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_nameTextField];
        
        __weak typeof(self) weakSelf = self;
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.logoLabel.mas_bottom).offset(KHEIGHT(40));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _phoneTextField.delegate = self;
        _phoneTextField.font = [UIFont systemFontOfSize:KWIDTH(32)];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _phoneTextField.placeholder = @"请输入座机(选填)";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(35), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_Phone"]];
        [leftView addSubview:phoneImageView];
        
        _phoneTextField.leftView = leftView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_phoneTextField];
        
        __weak typeof(self) weakSelf = self;
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameTextField.mas_bottom).offset(KHEIGHT(20));
            make.left.equalTo(weakSelf.nameTextField).offset(KHEIGHT(0));
            make.right.equalTo(weakSelf.nameTextField).offset(KHEIGHT(0));
            make.height.equalTo(weakSelf.nameTextField).offset(KHEIGHT(0));
        }];
    }
    return _phoneTextField;
}

- (UITextField *)addressTextField {
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc] init];
        _addressTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _addressTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _addressTextField.delegate = self;
        _addressTextField.font = [UIFont systemFontOfSize:KWIDTH(32)];
//        _addressTextField.keyboardType = UIKeyboardTypeNumberPad;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.returnKeyType = UIReturnKeyDone;
        _addressTextField.placeholder = @"请输入地址";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(35), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_Adress"]];
        [leftView addSubview:phoneImageView];
        
        _addressTextField.leftView = leftView;
        _addressTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_addressTextField];
        
        __weak typeof(self) weakSelf = self;
        [_addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.phoneTextField.mas_bottom).offset(KHEIGHT(20));
            make.left.equalTo(weakSelf.phoneTextField).offset(KHEIGHT(0));
            make.right.equalTo(weakSelf.phoneTextField).offset(KHEIGHT(0));
            make.height.equalTo(weakSelf.phoneTextField).offset(KHEIGHT(0));
        }];
    }
    return _addressTextField;
}

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [_photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:PHOTO_COLLECTIONCELL_ID];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
//        _photoCollectionView.scrollsToTop = NO;
//        _photoCollectionView.scrollEnabled = NO;
        [self.view addSubview:_photoCollectionView];
        
        __weak typeof(self) weakSelf = self;
        [_photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.addressTextField.mas_bottom).offset(KHEIGHT(20));
            make.left.equalTo(weakSelf.addressTextField);
            make.right.equalTo(weakSelf.addressTextField);
            make.height.offset(KHEIGHT(240));
        }];
        
        
        self.maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.maskButton.backgroundColor = [UIColor whiteColor];
        [self.maskButton addTarget:self action:@selector(removeMaskButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.maskButton];
        [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_photoCollectionView).offset(0);
            make.right.equalTo(_photoCollectionView).offset(0);
            make.top.equalTo(_photoCollectionView).offset(0);
            make.bottom.equalTo(_photoCollectionView).offset(0);
        }];
        
        UIImageView *photoImageView = [[UIImageView alloc] init];
        [photoImageView setImage:[UIImage imageNamed:@"Org_Register_Camera"]];
        [self.maskButton addSubview:photoImageView];
        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(KHEIGHT(65));
            make.height.offset(KHEIGHT(58));
            make.width.offset(KWIDTH(66));
        }];
        
        UILabel *photoLabel = [[UILabel alloc] init];
        photoLabel.text = @"上传机构风采";
        photoLabel.textColor = [CommonTool colorWithHexString:@"#9B9B9B"];
        photoLabel.font = [UIFont systemFontOfSize:16];
        [self.maskButton addSubview:photoLabel];
        [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(photoImageView.mas_bottom).offset(KHEIGHT(20));
        }];
        
    }
    return _photoCollectionView;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_nextButton];
        
        __weak typeof(self) weakSelf = self;
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.photoCollectionView.mas_bottom).offset(KHEIGHT(40));
            make.left.equalTo(weakSelf.photoCollectionView.mas_left);
            make.right.equalTo(weakSelf.photoCollectionView.mas_right);
            make.height.offset(KHEIGHT(90));
        }];
    }
    return _nextButton;
}

- (NSMutableArray *)orgImageArray {
    if (!_orgImageArray) {
        _orgImageArray = [[NSMutableArray alloc] init];
    }
    return _orgImageArray;
}

- (NSMutableArray *)resourceList {
    if (!_resourceList) {
        _resourceList = [[NSMutableArray alloc] init];
    }
    return _resourceList;
}

#pragma mark - textField delegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parser = [[SBJsonParser alloc] init];

    [self startLocation]; // 获取位置信息
    self.navigationItem.title = @"机构注册";
    self.view.backgroundColor = [CommonTool colorWithHexString:@"#f8f8f8"];
//    self.scrollView.scrollEnabled = YES;
    [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTextField resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - 按钮点击事件
- (void)removeMaskButton:(UIButton *)sender {
    self.selectImageType = SelectImageTypePhotos;
    [self addHead];
}

- (void)nextButtonAction:(UIButton *)sender {
//    if (self.logoImage == nil) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"请上传机构LOGO" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
    if (self.nameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请输入机构名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if (self.addressTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请输入地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
//    if (self.orgImageArray.count == 0) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"请上传机构风采" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
    
//    OrgRegisterStepFourVC *stepFourVC = [[OrgRegisterStepFourVC alloc] init];
//    [self.navigationController pushViewController:stepFourVC animated:YES];
    
    // 上传数据
    [self uploadToQN];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
}

#pragma mark - PhotoCollectionViewCellDelegate
-(void)photoCollectionViewCell:(PhotoCollectionViewCell *)cell selectedButtonClicked:(UIButton *)sender {
    NSIndexPath *index = [self.photoCollectionView indexPathForCell:cell];
    [self.orgImageArray removeObjectAtIndex:index.item];
    [self.photoCollectionView reloadData];
    NSLog(@"%@", index);
    if (self.orgImageArray.count == 0) {
        self.maskButton.hidden = NO;
    }
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.orgImageArray.count == 0) {
        return 1;
    } else if (self.orgImageArray.count > 0 && self.orgImageArray.count < 3) {
        return self.orgImageArray.count + 1;
    } else {
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_COLLECTIONCELL_ID forIndexPath:indexPath];
//    PhotoCollectionViewCell *cell = [[PhotoCollectionViewCell alloc] init];
    cell.type = 2;
    cell.delegate = self;
    if (self.orgImageArray.count <= 3) {
        if (indexPath.item == self.orgImageArray.count) {
            [cell.photoImageView setImage:[UIImage imageNamed:@"Org_Register_AddPhoto"]];
            cell.selectedButton.userInteractionEnabled = NO;
            [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

        } else {
            if (self.orgImageArray.count > 0) {
                [cell.photoImageView setImage:self.orgImageArray[indexPath.item]];
                [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Delete_1"] forState:UIControlStateNormal];
                cell.selectedButton.userInteractionEnabled = YES;
            }
        }
    }
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedIndex = indexPath.item;
    self.selectImageType = SelectImageTypePhotos;
    [self addHead];
}

#pragma mark - Collection view flow layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(KWIDTH(200), KWIDTH(200));;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, KWIDTH(20), 0, KWIDTH(20));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return KWIDTH(22.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return KWIDTH(22.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kLayoutScreenWidth, KHEIGHT(20));
}
#pragma mark - 选择照片
-(void)addHead {
    UIActionSheet  *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.tag = 1000;
    [ actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex0 {

    
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex0) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限 做一个友好的提示
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相册\n设置>隐私>照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            return ;
        } else {
            //打开相机
        }
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info0
{
//    [self.maskButton removeFromSuperview];
    if (self.selectImageType == SelectImageTypePhotos) {
        self.maskButton.hidden = YES;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    UIImage *image = [info0 objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *smallImage = [Util  imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*0.2, image.size.height*0.2)];
    if (self.selectImageType == SelectImageTypeLogo) {
        [self.logoButton setBackgroundImage:smallImage forState:UIControlStateNormal];
        self.logoImage = smallImage;
    } else if (self.selectImageType == SelectImageTypePhotos) {
        if (self.orgImageArray.count > 0) {
            if (self.orgImageArray.count == self.selectedIndex) {
                [self.orgImageArray addObject:smallImage];
            } else {
                [self.orgImageArray replaceObjectAtIndex:self.selectedIndex withObject:smallImage];
            }
            [self.photoCollectionView reloadData];
        } else {
            [self.orgImageArray addObject:smallImage];
            [self.photoCollectionView reloadData];
        }
    }
    
}

- (void)uploadToQN {
    if (self.logoImage == nil && self.orgImageArray.count == 0) {
        [self pushToNextView];
    } else if (self.orgImageArray.count == 0 && self.logoImage != nil) {
        [self uploadLogo];
    } else if (self.orgImageArray.count > 0 && self.logoImage == nil) {
        [self uploadOrgImages];
    } else {
        NSString *token =[ Util getUploadToken];
        
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        
        if (token) {
            NSData * data;
            
            UIImage* image = self.logoImage;
            data = UIImagePNGRepresentation(image);
            [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          
                          self.OrgLogoStr = [NSString stringWithFormat:@"%@%@",QiNiu_HOST,key];
                          
                          for (int i=0; i<self.orgImageArray.count; i++) {
                              NSData * data;
                              
                              UIImage* image = [self.orgImageArray objectAtIndex:i];
                              data = UIImagePNGRepresentation(image);
                              [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                                        complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                            
                                            [self.resourceList addObject:[NSString stringWithFormat:@"%@%@",QiNiu_HOST,key]];
                                            
                                            NSLog(@"声音===%@",[NSString stringWithFormat:@"%@%@",QiNiu_HOST,key]);
                                            
                                            if (self.resourceList.count == self.orgImageArray.count) {
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                
                                                [self pushToNextView];
                                            }
                                            
                                        } option:nil];
                          }
                      } option:nil];
            
        } else {
            //        [self performSelectorOnMainThread:@selector(showMesssage:) withObject:@"上传失败，请稍后再试" waitUntilDone:NO];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [Util showMesssage:@"上传图片失败，请稍后再试"];
        }
    }
    
    ////NSLog(@"getResourceList0");
    
    
}

- (void)uploadLogo {
    NSString *token =[ Util getUploadToken];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    if (token) {
        NSData * data;
        
        UIImage* image = self.logoImage;
        data = UIImagePNGRepresentation(image);
        [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      
                      self.OrgLogoStr = [NSString stringWithFormat:@"%@%@",QiNiu_HOST,key];
                      [self pushToNextView];
                      
                  } option:nil];
        
    } else {
        //        [self performSelectorOnMainThread:@selector(showMesssage:) withObject:@"上传失败，请稍后再试" waitUntilDone:NO];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Util showMesssage:@"上传图片失败，请稍后再试"];
    }
}

- (void)uploadOrgImages {
    NSString *token =[ Util getUploadToken];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];

    if (token) {
        for (int i=0; i<self.orgImageArray.count; i++) {
            NSData * data;
            
            UIImage* image = [self.orgImageArray objectAtIndex:i];
            data = UIImagePNGRepresentation(image);
            [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          
                          [self.resourceList addObject:[NSString stringWithFormat:@"%@%@",QiNiu_HOST,key]];
                          
                          NSLog(@"声音===%@",[NSString stringWithFormat:@"%@%@",QiNiu_HOST,key]);
                          
                          if (self.resourceList.count == self.orgImageArray.count) {
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
                              [self pushToNextView];
                          }
                          
                      } option:nil];
        }
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Util showMesssage:@"上传图片失败，请稍后再试"];
    }
}

- (void)pushToNextView {
    /*
     *orgName;             // 机构名称
     *orgAddress;          // 机构地址
     *phoneNumber;         // 手机号号码  请求参数 email
     *teleNumber;          // 座机号码    请求参数 phone
     *password;            // 密码
     *codeNumber;          // 验证码
     *logoStr;             // 机构LOGO 七牛返回的Str
     *resourceListArray;    // 机构风采  七牛返回的Str数组
     */
    OrgRegisterStepFourVC *stepFourVC = [[OrgRegisterStepFourVC alloc] init];
    stepFourVC.orgName = self.nameTextField.text;
    stepFourVC.orgAddress = self.addressTextField.text;
    stepFourVC.phoneNumber = self.phoneNum;
    stepFourVC.teleNumber = self.phoneTextField.text;
    stepFourVC.password = self.passWordNum;
    stepFourVC.codeNumber = self.codeNum;
    stepFourVC.logoStr = self.OrgLogoStr;
    stepFourVC.resourceListArray = self.resourceList;
    [self.navigationController pushViewController:stepFourVC animated:YES];
}

//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);//市
            NSLog(@"--%@",placemark.name);//黄河大道221号
            NSLog(@"++++%@",placemark.subLocality); //区
            NSLog(@"country == %@",placemark.country);//中国
            NSLog(@"administrativeArea == %@",placemark.administrativeArea); //河北省
            self.addressTextField.text = [NSString stringWithFormat:@"%@%@%@%@", placemark.administrativeArea, city, placemark.subLocality, placemark.name];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
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

@end

//
//  Tencent is pleased to support the open source community by making LKImageKit available.
//  Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
//  Licensed under the BSD 3-Clause License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//  https://opensource.org/licenses/BSD-3-Clause
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
//
//  Created by lingtonke

#import "LKImageBundleLoader.h"
#import "LKImageDefine.h"
#import "LKImageRequest.h"
#import "LKImageUtil.h"

@implementation LKImageBundleLoader

- (BOOL)isValidRequest:(LKImageRequest *)request
{
    if ([request isKindOfClass:[LKImageURLRequest class]])
    {
        NSString *URL = ((LKImageURLRequest *) request).URL;
        if (URL.length > 0)
        {
            return YES;
        }
    }
    return NO;
}

- (void)imageWithRequest:(LKImageRequest *)request callback:(LKImageImageCallback)callback
{
    if ([request isKindOfClass:[LKImageURLRequest class]])
    {
        NSString *URL       = ((LKImageURLRequest *) request).URL;
        NSString *extension = URL.pathExtension;
        UIImage *image      = nil;
        if (extension.length>0)
        {
            NSString *fullname  = [URL lastPathComponent];
            NSString *name      = [fullname stringByDeletingPathExtension];
            NSString *path      = [[NSBundle mainBundle] pathForResource:name ofType:extension];
            image               = [UIImage imageWithContentsOfFile:path];
            
        }
        else
        {
            image = [UIImage imageNamed:URL];
        }
        
        if (!image)
        {
            NSError *error = [LKImageError errorWithCode:LKImageErrorCodeFileNotFound];
            callback(request, nil, 0, error);
        }
        else
        {
            callback(request, image, 1, nil);
        }
        
    }
    else
    {
        NSError *error = [LKImageError errorWithCode:LKImageErrorCodeInvalidLoader];
        callback(request, nil, 0, error);
    }
}

@end

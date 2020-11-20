//
//  main.m
//  Demo
//
//  Created by hank on 2020/3/11.
//  Copyright © 2020 hank. All rights reserved.
//

#import <stdio.h>
//#define C 30
//typedef int HK_INT_64;

int test(int a,int b){
    return a + b + 3;
}


int main(int argc, const char * argv[]) {
    int a = test(1, 2);
    printf("%d",a);
    return 0;
}

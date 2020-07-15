//
//  main.m
//  LGCallocTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>
#import <malloc/malloc.h>

void test(int param, int* p, int** q)
{
	printf("%p\n", &param);
	printf("%p\n", p);
	printf("%p\n", q);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
		
		
		void *p = calloc(1, 24); // 32
		NSLog(@"%lu",malloc_size(p));
		
		int a = 10;
		int *q = &a;
		int **b = &q;
	
		
		printf("%p\n", &a);
		printf("%p\n", *b);	//q
		printf("%p\n", &q);
		printf("%p\n", &b);
		
		test(a, q, b);
    }
    return 0;
}


#include<iostream>
#include<stdio.h>
#include<cuda.h>
#include<cuda_runtime_api.h>
using namespace std;
# define size 5
__global__ void AddIntsCUDA(int *a, int *b)
{
	//for(int i=0;i<size;i++)
	//{
	int tid=blockIdx.x*blockDim.x+threadIdx.x;
	a[tid] = a[tid] + b[tid];

	//}
}
__global__ void SubIntsCUDA(int *a, int *b)

{
	//for(int i=0;i<size;i++)
	//{
	int tid=blockIdx.x*blockDim.x+threadIdx.x;
	b[tid] = a[tid] - b[tid];

	//}
}

int main()
{
	int a[size]={1,2,3,4,5}, b[size]={1,2,3,4,5};
	int *d_a, *d_b;

	cudaMalloc((void **)&d_a, sizeof(int)*size);
	cudaMalloc((void **)&d_b, sizeof(int)*size);
	cudaMemcpy(d_a, &a, sizeof(int)*size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int)*size, cudaMemcpyHostToDevice);

	AddIntsCUDA << <2,3 >> >(d_a, d_b);

	cudaMemcpy(&a, d_a, sizeof(int)*size, cudaMemcpyDeviceToHost);


	cout << "The answer is "<<endl;
	for(int i=0;i<size;i++)
	{
		printf("a[%d]=%d\n",i,a[i]);
	}
	cudaFree(d_a);
	cudaFree(d_b);
	free(a);
	free(b);

	/*int a[size]={1,2,3,4,5}, b[size]={1,2,3,4,5};

	cudaMalloc((void **)&d_a, sizeof(int)*size);
	cudaMalloc((void **)&d_b, sizeof(int)*size);
	cudaMemcpy(d_a, &a, sizeof(int)*size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int)*size, cudaMemcpyHostToDevice);

	SubIntsCUDA << <2,3 >> >(d_a, d_b);
	cudaMemcpy(&b, d_b, sizeof(int)*size, cudaMemcpyDeviceToHost);
	cout << "\nThe Subtraction is "<<endl;
		for(int i=0;i<size;i++)
		{
			printf("b[%d]=%d\n",i,b[i]);
		}
*
	cudaFree(d_a);
	cudaFree(d_b);

*/

//	AddIntsCUDA << <1, 1 >> >(d_a, d_b);


	return 0;
}


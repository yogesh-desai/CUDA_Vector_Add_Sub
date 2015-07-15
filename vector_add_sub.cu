/*Title: Vector addition and subtraction in CUDA.
A simple way to understand how CUDA can be used to perform arithmetic operations.
*/
#include<iostream>
#include<stdio.h>
#include<cuda.h>
#include<cuda_runtime_api.h>
using namespace std;
# define size 5

//Global functions
__global__ void AddIntsCUDA(int *a, int *b)
{
	int tid=blockIdx.x*blockDim.x+threadIdx.x;
	a[tid] = a[tid] + b[tid];
}

__global__ void SubIntsCUDA(int *a, int *b)
{
	int tid=blockIdx.x*blockDim.x+threadIdx.x;
	b[tid] = a[tid] - b[tid];
}
//********************************************************
int main()
{
	int a[size]={1,2,3,4,5}, b[size]={1,2,3,4,5}; //Vector Declaration and Definition
	int *d_a, *d_b;

	//Allocation of Device variables
	cudaMalloc((void **)&d_a, sizeof(int)*size);
	cudaMalloc((void **)&d_b, sizeof(int)*size);

	//Copy Host Memory to Device Memory
	cudaMemcpy(d_a, &a, sizeof(int)*size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int)*size, cudaMemcpyHostToDevice);
	
	//Launch Kernel
	AddIntsCUDA << <2,3 >> >(d_a, d_b);
	
	//Copy Device Memory to Host Memory
	cudaMemcpy(&a, d_a, sizeof(int)*size, cudaMemcpyDeviceToHost);

	cout << "The answer is "<<endl;
	for(int i=0;i<size;i++)
	{
		printf("a[%d]=%d\n",i,a[i]);
	}

	//Deallocate the Device Memory and Host Memory
	cudaFree(d_a);
	cudaFree(d_b);
	free(a);
	free(b);

	return 0;
}

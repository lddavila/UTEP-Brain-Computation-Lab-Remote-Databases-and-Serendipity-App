#include <sys/types.h>
#include <unistd.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[],
int nrhs, const mxArray *prhs[])
{
unsigned int *pr;

plhs[0] = mxCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
pr = mxGetData(plhs[0]);
*pr = (unsigned int)getpid();
} 
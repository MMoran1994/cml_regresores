//
// Created by clinux01 on 08/11/19.
//

#include "auxiliares.h"


double ecm(Vector yPred, Vector yTest){
    long n = yPred.size();
    double res = 0;
    for(int i = 0; i < n; ++i){
        res += pow(yPred(i) - yTest(i), 2);
    }
    res /= n;
    return sqrt(res);
}

#ifndef CML_LIBRARY_H
#define CML_LIBRARY_H
#include <iostream>
#include <math.h>
#include "types.h"

#define _USE_MATH_DEFINES


class RegresorPolinomial{
public:
    RegresorPolinomial(int grado);
    void mostrar();
    //Matrix armar_matriz_A(Vector xi);
    void fit(Matrix A, Vector yi);
    Vector predict(Vector xs);
    Vector mostrarCoefs();

private:
    int _grado;
    Vector _coefs;
};

//-------------------------------------------------------------------------------------------//

class RegresorLinearYPeriodico{
public:
    RegresorLinearYPeriodico();
    Matrix armar_matriz_A(Vector xi);
    void fit(Vector xi, Vector yi);
    Vector predict(Vector xs);
    Vector mostrarCoefs();

private:
    Vector _coefs;
};

//-------------------------------------------------------------------------------------------//

class RegresorSenoide{
public:
    RegresorSenoide();
    void fit(Matrix A, Vector yi);
    Vector predict(Vector xs);
    Vector mostrarCoefs();

private:
    Vector _coefs;
};

#endif
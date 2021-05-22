#include "regresiones.h"


RegresorPolinomial::RegresorPolinomial(int grado) : _grado(grado) {

}

void RegresorPolinomial::mostrar(){
    std::cout << _coefs << std::endl;
}

/*
Matrix RegresorPolinomial::armar_matriz_A(Vector xi) {
    long m = xi.size();
    Matrix A(m, _grado + 1);
    Vector unos = Vector::Ones(m);
    A.col(0) = unos;
    for (int i = 1; i < _grado + 1; ++i) {
        Vector pots = xi;
        for(int j = 0; j < pots.size(); j++){ //elevo el vector a la i
            pots(j) = pow(pots(j),i);
        }
        A.col(i) = pots;
    }
    return A;
}
*/


void RegresorPolinomial::fit(Matrix A, Vector yi) {
    //Matrix A(xi.size()i;, _grado + 1);
    //A = armar_matriz_A(xi);
    Matrix AtA = A.transpose() * A;
    Matrix Atb = A.transpose() * yi;
    _coefs = AtA.llt().solve(Atb);
}

Vector RegresorPolinomial::predict(Vector xs) {
    Vector ret = Vector::Zero(xs.size());
    for(int i = 0; i < _grado + 1; ++i){
        Vector pots = xs;
        for(int j = 0; j < pots.size(); j++){ //elevo el vector a la i
            pots(j) = pow(pots(j),i);
        }
        ret += _coefs(i) * pots;
    }
    return ret;
}

Vector RegresorPolinomial::mostrarCoefs(){
	return _coefs;
}

//------------------------------------------------------------------------------------------------------//


RegresorLinearYPeriodico::RegresorLinearYPeriodico() = default;

Matrix RegresorLinearYPeriodico::armar_matriz_A(Vector xi) {
    long m = xi.size();
    Matrix A(m, 4);
    Vector unos = Vector::Ones(m);
    A.col(0) = unos;
    A.col(1) = xi;
    Vector senos = xi;
    for(int i = 0; i < xi.size(); i++){
        senos(i) = sin(senos(i));
    }
    A.col(2) = senos;
    Vector cosenos = xi;
    for(int i = 0; i < xi.size(); i++){
        cosenos(i) = cos(cosenos(i));
    }
    A.col(3) = cosenos;
    return A;
}

void RegresorLinearYPeriodico::fit(Vector xi, Vector yi) {
    Matrix A(xi.size(), 4);
    A = armar_matriz_A(xi);
    Matrix AtA = A.transpose() * A;
    Matrix Atb = A.transpose() * yi;
    _coefs = AtA.llt().solve(Atb);
}

Vector RegresorLinearYPeriodico::predict(Vector xs) {
    Vector ret = Vector::Zero((xs.size()));
    for(int i = 0; i < ret.size(); ++i){
        ret(i) += _coefs[0];
        ret(i) += _coefs[1] * xs(i);
        ret(i) += _coefs[2] * sin(xs(i));
        ret(i) += _coefs[3] * cos(xs(i));
    }
    return ret;
}

Vector RegresorLinearYPeriodico::mostrarCoefs(){
	return _coefs;
}

//------------------------------------------------------------------------------------------------------//

RegresorSenoide::RegresorSenoide() = default;


void RegresorSenoide::fit(Matrix A, Vector yi) {
    Matrix AtA = A.transpose() * A;
    Matrix Atb = A.transpose() * yi;
    _coefs = AtA.llt().solve(Atb);
}

Vector RegresorSenoide::predict(Vector xs) {
    Vector ret = Vector::Zero((xs.size()));
    for(int i = 0; i < ret.size(); i++){        //suma de familias de funciones
        ret(i) += _coefs[0];
        ret(i) += _coefs[1] * xs(i);
        for(int k = 2; k < _coefs.size(); k++) {
            double dosPiT = 2 * M_PI * xs(i);
            double div = (double) k-1;
            ret(i) += _coefs[k] * sin(dosPiT/(div));       //f(t) = sen(2Pi*t / k)
        }
    }
    return ret;
}

Vector RegresorSenoide::mostrarCoefs() {
    return _coefs;
}

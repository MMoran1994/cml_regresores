//
// Created by clinux01 on 05/11/19.
//

#ifndef TP3_TYPES_H
#define TP3_TYPES_H

#include "../eigen/Eigen//Dense"
#include "../eigen/Eigen/Sparse"

using Eigen::MatrixXd;

typedef Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic> Matrix;
typedef Eigen::SparseMatrix<double> SparseMatrix;

typedef Eigen::VectorXd Vector;

#endif //TP3_TYPES_H

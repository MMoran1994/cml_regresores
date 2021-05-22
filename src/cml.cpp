//
// Created by clinux01 on 08/11/19.
//

#include "../pybind11/include/pybind11/pybind11.h"
#include "../pybind11/include/pybind11/eigen.h"
#include "../pybind11/include/pybind11/stl.h"
#include "types.h"
#include "regresiones.h"
#include "auxiliares.h"


namespace  py=pybind11;

PYBIND11_MODULE(cml,m) {
    py::class_<RegresorPolinomial>(m, "RegresorPolinomial")
         .def(py::init<int>())
         .def("mostrar", &RegresorPolinomial::mostrar)
         .def("fit", &RegresorPolinomial::fit)
         .def("predict", &RegresorPolinomial::predict)
         .def("mostrarCoefs", &RegresorPolinomial::mostrarCoefs);
         //.def("armar_matriz_A", &RegresorPolinomial::armar_matriz_A);

    py::class_<RegresorLinearYPeriodico>(m, "RegresorLinearYPeriodico")
            .def(py::init<>())
            .def("fit", &RegresorLinearYPeriodico::fit)
            .def("predict", &RegresorLinearYPeriodico::predict)
            .def("armar_matriz_A", &RegresorLinearYPeriodico::armar_matriz_A)
            .def("mostrarCoefs", &RegresorLinearYPeriodico::mostrarCoefs);

    py::class_<RegresorSenoide>(m, "RegresorSenoide")
            .def(py::init<>())
            .def("fit", &RegresorSenoide::fit)
            .def("predict", &RegresorSenoide::predict)
            .def("mostrarCoefs", &RegresorSenoide::mostrarCoefs);
            //.def("armar_matriz_A", &RegresorSenoide::armar_matriz_A);

    m.def("ecm", &ecm, "Calculo ecm");
};

